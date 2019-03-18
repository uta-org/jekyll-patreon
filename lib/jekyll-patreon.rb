# Jekyll::Patreon is a gem built for Jekyll 3 that generates a widget of your Patreon's profile
#
# Author: z3nth10n (United Teamwork Association)
# Site: https://github.com/uta-org/jekyll-patreon
# Distributed Under The MIT License (MIT) as described in the LICENSE file
#   - https://opensource.org/licenses/MIT

require "jekyll-patreon/version"
# Files needed for the widget generator
require "jekyll-patreon/generator/defaults"
require "jekyll-patreon/generator/patreonGenerator"
# Files needed for parsing
require "jekyll-patreon/parsers/patreonParser"
# Files needed for displaying the widget
require "jekyll-patreon/tags/patreonTag"

module Jekyll 
  module Patreon
  end # module Patreon
end # module Jekyll