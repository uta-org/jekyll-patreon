module Jekyll
  module Patreon::Generator      
    #
    # The main entry point into the generator, called by Jekyll
    # this function extracts all the necessary information from the jekyll end and passes it into the pagination 
    # logic. Additionally it also contains all site specific actions that the pagination logic needs access to
    # (such as how to create new pages)
    # 
    class PatreonGenerator < Generator
      # The constants
        
      PatreonWebsiteURL = "https://www.patreon.com/"
      PatreonUserAPIURL = "https://api.patreon.com/user/"
        
      # The vars 
        
      @@config ||= nil
      @@PatreonID ||= nil
      @@json ||= nil
        
      # This generator is safe from arbitrary code execution.
      safe true

      # This generator should be passive with regard to its execution
      priority :lowest
      
      # Generate paginated pages if necessary (Default entry point)
      # site - The Site.
      #
      # Returns nothing.
      def generate(site)
      #begin
        
        Jekyll.logger.info "Patreon:","Initializating"
        
        start = Time.now
          
        # Retrieve and merge the Patreon configuration from the site yml file
        default_config = Jekyll::Utils.deep_merge_hashes(DEFAULT, site.config['patreon'] || {})
        @@config = default_config
          
        username = @@config["username"]
          
        if username.nil?
           username = "z3nth10n" 
        end
        
        if @@PatreonID.nil?
            @@PatreonID = internalGetPatreonID(username)
        else
            infoSpended(start)
            return
        end
            
        # Jekyll.logger.info "Patreon lang:",@config['lang']

        @@json = Net::HTTP.get_response(URI.parse("#{PatreonUserAPIURL}#{@@PatreonID}")).body.force_encoding('UTF-8').escape_json
        infoSpended(start)
      end
        
      def infoSpended(start)
          spended = Time.now - start
          Jekyll.logger.info "Patreon:", "Initialized in #{spended} seconds"
      end
        
      def internalGetPatreonID(username)
          patreon_url = URI.encode("#{PatreonWebsiteURL}#{username}")

          # Jekyll.logger.info "Patreon profile url:",patreon_url
          patreon_source = Net::HTTP.get_response(URI.parse(patreon_url)).body.force_encoding('UTF-8').delete!("\r\n\\")

          patreon_id_index = patreon_source.index("\"creator_id\": ")

          unless patreon_id_index.nil?

              patreon_id_index += 14
              endidpos = patreon_source.from(patreon_id_index).index("\n")

              if endidpos.nil?
                endidpos = patreon_source.from(patreon_id_index).index("}")
              end

              if endidpos.nil?
                  raiseError()
              end

              patreon_id = patreon_source.from(patreon_id_index)[0, endidpos].strip

              # Jekyll.logger.info "Patreon ID:",patreon_id

              if patreon_id.nil?
                  raiseError()
              end

              return Integer(patreon_id)
          end

          return -1
      end
        
      def self.getConfig
         @@config 
      end
        
      def self.getPatreonID
         @@PatreonID
      end
        
      def self.getJSON
         @@json
      end
    end
  end
end