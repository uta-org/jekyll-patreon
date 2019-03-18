require 'json'

module Jekyll
    module Patreon::Parsers
        class PatreonParser
            def self.parseJson(jsonStr)
                return JSON.parse(jsonStr)
            end
        end
    end
end