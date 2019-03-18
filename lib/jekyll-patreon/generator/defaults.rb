module Jekyll
  module Patreon::Generator

    # The default configuration for the Patreon widget
    DEFAULT = {
      'enabled'      => false,
      'design'       => 'default', # Supports the following desings: default, fancy, minimal, streamlined, reversed, swapped
      'title'        => '',
      'metercolor'   => "green", # Supports the following colors: reed, green, orange, red nostripes, green nostripes, orange nostripes, blue nostripes
      'toptext'      => "", # Text that appears in before the progress bar
      'bottomtext'   => "", # Text that appears in after the progress bar
      'showgoaltext' => true,
      'showbutton'   => false,
      'username'     => 'z3nth10n',
      'default_lang' => "en"
    }

  end # module Patreon
end # module Jekyll