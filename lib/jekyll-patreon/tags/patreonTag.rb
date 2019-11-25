# Jekyll - Easy Patreon Embed
#
# z3nth10n - https://github.com/z3nth10n
# United Teamwork Association - https://github.com/uta-org 
#
#   Input:
#     {% patreon z3nth10n %}
#   Output: Patreon donation widget

require 'net/http'

module Jekyll
  module Patreon::Tags 
      class PatreonTag < Liquid::Tag
        @inc = nil
        @username = nil
        @PatreonID = nil
        @config = nil
        @json = nil
        @language = nil
        @confDefLang = nil

        def initialize(tag_name, markup, tokens)
          super
            
          @inc = File.expand_path(File.join("..", "..", "_inc"), __FILE__)
            
          @config = Jekyll::Patreon::Generator::PatreonGenerator.getConfig
            
          @username = @config["username"]
          @confDefLang = @config["default_lang"]
          @PatreonID = Jekyll::Patreon::Generator::PatreonGenerator.getPatreonID # TODO: Update this
          @json = Jekyll::Patreon::Generator::PatreonGenerator.getJSON
        end

        def render(context)

          # TODO: Fix this
          if @PatreonID == -1
            return
          end

          unless @config['enabled']
             return 
          end
            
          @language = Jekyll::Patreon.get_language(context)
            
          if @language.to_s.empty? and !@confDefLang.to_s.empty?
             @language = @confDefLang.to_s
          elsif @language.to_s.empty? and @confDefLang.to_s.empty?
             @language = "en"
          end

          trFile = File.expand_path(File.join('..', '..', 'langs', "#{@language}.yml"), __FILE__)
          ymlConf = YAML.load_file(trFile)
            
          source = "<script>" + File.read(File.join(@inc, "js", "patreon.js")).interpolate({per: ymlConf["per"], month: ymlConf["month"], patrons: ymlConf["patrons"], of: ymlConf["of"], reached: ymlConf["reached"]}) + "</script>"
          source += File.read(File.join(@inc, "design_" + @config['design'] + ".html")).interpolate({ json: translateJson(context, @json), showgoaltext: @config['showgoaltext'], toptext: @config['toptext'], metercolor: @config['metercolor'], bottomtext: @config['bottomtext'], patreon_button: @config['patreon_button'] })
          
          if @config['showbutton']
            if @language == @confDefLang
                source += File.read(File.join(@inc, "button.html")).interpolate(pid: @PatreonID)
            else
                source += File.read(File.join(@inc, "translated_button.html")).interpolate({pid: @PatreonID, caption: ymlConf["caption"]})
            end
          end
            
          source += "<style>" + File.read(File.join(@inc, "css", "design_" + @config['design'] + ".css")) + "</style>"
          source += "<style>" + File.read(File.join(@inc, "css", "common.css")) + "</style>"

          source
        end

        def raiseError()
            raise RuntimeError, "An error occurred getting the ID from your Patreon profile"
        end
          
        def translateJson(context, jsonStr)
          
            
          if @language.to_s.empty? or @language == @confDefLang
             return jsonStr.escape_json  
          end    
            
          json = Jekyll::Patreon::Parsers::PatreonParser.parseJson(jsonStr)

          incl = json["included"]
          startIndex = 0
            
          incl.each_with_index do |item, index|
             startIndex = index
             break if item["type"] == "goal"
          end
            
          trFile = File.expand_path(File.join('..', '..', '..', '..', '..', '..', '_data', 'lang', "#{@language}.yml"), __FILE__)
          ymlConf = YAML.load_file(trFile)
            
          # Get markdownify pipe
          converter = context.registers[:site].find_converter_instance(Jekyll::Converters::Markdown)
            
          for index in (startIndex..incl.length - 1)
             i = index - startIndex
              
             json["included"][index]["attributes"]["description"] = converter.convert(ymlConf["patreon_goal_#{i}"].to_s).gsub("<p>", "").gsub("</p>", "")
          end
        
          return JSON.dump(json).escape_json
        end
      end
  end
end

# Jekyll.logger.info "Patreon:","Test"
Liquid::Template.register_tag('patreon', Jekyll::Patreon::Tags::PatreonTag)