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

## Advanced Options

Growl also supports some customization through the following options:

- **delayOnHover**: while hovering over the alert, prevent it from being dismissed (true | false - **default**: true)
- **duration**: the duration (in milliseconds) for which the alert is displayed (**default**: 3200)
- **fixed**: whether the alert should be fixed rather than auto-dismissed (true | false - **default**: false)
- **location**: the alert's position ('tl' | 'tr' | 'bl' | 'br' | 'tc' | 'bc' - **default**: 'tr')
- **size**: the alert's size ('small' | 'medium' | 'large' - **default**: 'medium')
- **style**: the alert's style ('default' | 'error' | 'notice' | 'warning' - **default**: 'default')

### Deprecations

- **static** has been renamed to **fixed** due to minifier incompatabilities

## Status

[![Status](https://travis-ci.org/ksylvest/jquery-growl.png)](https://travis-ci.org/ksylvest/jquery-growl)

## Copyright

Copyright (c) 2010 - 2018 Kevin Sylvestre. See LICENSE for details.
