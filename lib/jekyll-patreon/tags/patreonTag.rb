# Jekyll - Easy Patreon Embed
#
# z3nth10n - https://github.com/z3nth10n
# United Teamwork Association - https://github.com/uta-org 
#
#   Input:
#     {% patreon z3nth10n %}
#   Output: Patreon donation widget

require "jekyll-patreon/version"
require 'net/http'

module Jekyll
  module Patreon::Tags 
      class PatreonTag < Liquid::Tag
        PatreonWebsiteURL = "https://www.patreon.com/"
        PatreonUserAPIURL = "https://api.patreon.com/user/"
          
        @inc = nil
        @username = nil
        @PatreonID = nil
        @config = nil

        def initialize(tag_name, markup, tokens)
          super

          @inc = File.expand_path("../../_inc", __FILE__)
          @username = markup.strip
          @config = Jekyll::Patreon::Generator::PatreonGenerator.getConfig
        end

        def render(context)
          unless @config['enabled']
             return 
          end
            
          if @PatreonID.nil?
             @PatreonID = getPatreonID(@username) 
          end

          json = Net::HTTP.get_response(URI.parse("#{PatreonUserAPIURL}#{@PatreonID}")).body.force_encoding('UTF-8').escape_json

          source = "<script>" + File.read(File.join(@inc, "js", "patreon.js")) + "</script>"
          source += File.read(File.join(@inc, "design_" + @config['design'] + ".html")).interpolate({ json: json, showgoaltext: @config['showgoaltext'], toptext: @config['toptext'], metercolor: @config['metercolor'], bottomtext: @config['bottomtext'], patreon_button: @config['patreon_button'] })
          
          if @config['showbutton']
            source += File.read(File.join(@inc, "button.html")).interpolate(pid: @PatreonID)
          end
            
          source += "<style>" + File.read(File.join(@inc, "css", "design_" + @config['design'] + ".css")) + "</style>"
          source += "<style>" + File.read(File.join(@inc, "css", "common.css")) + "</style>"

          source
        end

        def getPatreonID(username)
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

        def raiseError()
            raise RuntimeError, "An error occurred getting the ID from your Patreon profile"
        end
      end
  end
end

# Jekyll.logger.info "Patreon:","Test"
Liquid::Template.register_tag('patreon', Jekyll::Patreon::Tags::PatreonTag)