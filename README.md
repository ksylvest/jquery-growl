# jQuery Growl

Growl is a jQuery plugin designed to provide informative messages in the browser.

## Installation

To install copy the *javascripts*, and *stylesheets* directories into your project and add the following snippet to the header:

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>
    <script src="javascript/jquery.growl.js" type="text/javascript"></script>
    <link href="stylesheets/jquery.growl.css" rel="stylesheet" type="text/css" />

This plugin is also registered under http://bower.io/ to simplify integration. Try:

    npm install -g bower
    bower install growl

**Gemfile**

    + source 'https://rails-assets.org'
    ...
    + gem 'rails-assets-growl'

**application.css**

    /*
     ...
     *= require growl
     ...
    */

**application.js**

    //= require jquery
    ...
    //= require growl


## Examples

Growling is easy:

    <script type="text/javascript">
      $.growl({ title: "Growl", message: "The kitten is awake!", url: "/kittens" });
      $.growl.error({ message: "The kitten is attacking!" });
      $.growl.notice({ message: "The kitten is cute!" });
      $.growl.warning({ message: "The kitten is ugly!" });
    </script>

## Advanced

Growl also supports some customization through the following options:

- **fixed**: (true / false) enable or disable the auto-dismiss functionality (default: false)
- **size**: ('small' / 'medium' / 'large') customize the sizing of the alerts (default: 'medium')
- **style**: ('default' / 'error' / 'notice' / 'warning') customize the styling of the alerts (default: 'default')
- **location**: ('tl' / 'tr' / 'bl' / 'br' / 'tc' / 'bc') customize the position of the growl alerts (default: 'tr')
- **delayOnHover**: (true / false) prevent the growl from dismissing when mouse is over. (default: true)
- **waitForTransition**: (true / false) If CSS transition is present during animation, wait for it to end before firing callback (default: true). Note: If you have restyled a notifcation and it does not dismiss when you click the close button, set this to false to ignore the CSS transition event.

### Deprecations

- **static** has been renamed to **fixed** due to minifier incompatabilities

## Status

[![Status](https://travis-ci.org/ksylvest/jquery-growl.png)](https://travis-ci.org/ksylvest/jquery-growl)

## Copyright

Copyright (c) 2010 - 2015 Kevin Sylvestre. See LICENSE for details.
