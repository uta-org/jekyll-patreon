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
        @inc = nil
        @username = nil
        @PatreonID = nil
        @config = nil
        @json = nil

        def initialize(tag_name, markup, tokens)
          super
            
          @inc = File.expand_path("../../_inc", __FILE__)
            
          @config = Jekyll::Patreon::Generator::PatreonGenerator.getConfig
            
          @username = @config["username"]
          @PatreonID = Jekyll::Patreon::Generator::PatreonGenerator.getPatreonID
          @json = Jekyll::Patreon::Generator::PatreonGenerator.getJSON
        end

        def render(context)
          unless @config['enabled']
             return 
          end

          source = "<script>" + File.read(File.join(@inc, "js", "patreon.js")) + "</script>"
          source += File.read(File.join(@inc, "design_" + @config['design'] + ".html")).interpolate({ json: @json, showgoaltext: @config['showgoaltext'], toptext: @config['toptext'], metercolor: @config['metercolor'], bottomtext: @config['bottomtext'], patreon_button: @config['patreon_button'] })
          
          if @config['showbutton']
            # source += "<script>" + File.read(File.join(@inc, "js", "becomePatronButton.bundle.js")).force_encoding('UTF-8') + "</script>" 
            source += File.read(File.join(@inc, "button.html")).interpolate(pid: @PatreonID)
          end
            
          source += "<style>" + File.read(File.join(@inc, "css", "design_" + @config['design'] + ".css")) + "</style>"
          source += "<style>" + File.read(File.join(@inc, "css", "common.css")) + "</style>"

          source
        end

        def raiseError()
            raise RuntimeError, "An error occurred getting the ID from your Patreon profile"
        end
      end
  end
end

# Jekyll.logger.info "Patreon:","Test"
Liquid::Template.register_tag('patreon', Jekyll::Patreon::Tags::PatreonTag)