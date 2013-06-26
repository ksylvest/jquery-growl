# jQuery Growler

Growler is a jQuery plugin designed to provide informative messages in the browser.

## Installation

To install copy the *images*, *javascripts*, and *stylesheets* directories into your project and add the following snippet to the header:

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>
    <script src="javascript/jquery.growl.js" type="text/javascript"></script>
    <link href="stylesheets/jquery.growl.css" rel="stylesheet" type="text/css" />

## Examples

Growling is easy:

    <script type="text/javascript">
      $.growl({ title: "Growl", message: "The kitten is awake!" });
      $.growl.error({ message: "The kitten is attacking!" });
      $.growl.notice({ message: "The kitten is cute!" });
      $.growl.warning({ message: "The kitten is ugly!" });
    </script>

# Copyright

Copyright (c) 2010 - 2013 Kevin Sylvestre. See LICENSE for details.
