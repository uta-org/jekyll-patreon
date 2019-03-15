# jekyll-patreon [![Build Status](https://travis-ci.org/uta-org/jekyll-patreon.svg?branch=master)](https://travis-ci.org/uta-org/jekyll-patreon) [![Gem Version](https://badge.fury.io/rb/jekyll-patreon.svg)](http://badge.fury.io/rb/jekyll-patreon)

Requires Ruby 2.3+ and Jekyll +3.0

> A Jekyll plugins that adds Patreon support in your blog to easily embed a widget with goals

## Features 

* Supports several designs: default, fancy, minimal, streamlined, reversed, swapped
* Supports several colors: red, green, orange, red nostripes, green nostripes, orange nostripes, blue nostripes

> To see the possible styles && designs navigate to the assets folder where the screenshots are located

## Installation

Add this line to your site's Gemfile:

```ruby
gem 'jekyll-patreon'
```

Add this configuration to your _config.yml file:

```yaml
####################
# Patreon Settings #
####################

patreon:
    enabled: true
    design: 'default' # Supports the following desings: default, fancy, minimal, streamlined, reversed, swapped
    title: 'Example title'
    metercolor: 'green' # Supports the following colors: red, green, orange, red nostripes, green nostripes, orange nostripes, blue nostripes
    toptext: 'Example top text' # Text that appears in before the progress bar (optional)
    bottomtext: 'Example bottom text' # Text that appears in after the progress bar (optional)
    showgoaltext: true # Display the goal text?
    showbutton: true # Display the "Become a patron" button?
    username: 'Your username here'
```

## Usage

Simply just put the following tag where you need this:

`{% patreon %}`

## Issues

Having issues? Just report in [the issue section](https://github.com/uta-org/jekyll-patreon/issues). **Thanks for the feedback!**

## Contribute

Fork this repository, make your changes and then issue a pull request. If you find bugs or have new ideas that you do not want to implement yourself, file a bug report.

## Donate

Become a patron, by simply clicking on this button (**very appreciated!**):

[![](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/z3nth10n)

... Or if you prefer an one-time donation:

[![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/z3nth10n)

## Copyright

Copyright (c) 2019 z3nth10n (United Teamwork Association).

License: MIT