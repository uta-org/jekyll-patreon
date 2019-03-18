module Jekyll
    module Patreon
        def self.get_language(context)
            language = context.registers[:page]['language']
            return language
        end
    end
end