module Jekyll
  module Patreon::Generator
  
    @@config = nil  
      
    #
    # The main entry point into the generator, called by Jekyll
    # this function extracts all the necessary information from the jekyll end and passes it into the pagination 
    # logic. Additionally it also contains all site specific actions that the pagination logic needs access to
    # (such as how to create new pages)
    # 
    class PatreonGenerator < Generator
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
          
        # Retrieve and merge the Patreon configuration from the site yml file
        default_config = Jekyll::Utils.deep_merge_hashes(DEFAULT, site.config['patreon'] || {})
        @@config = default_config
      end
        
      def self.getConfig
         @@config 
      end
    end
  end
end