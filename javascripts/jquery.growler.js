/*!
 * jQuery Growler
 *
 * Copyright 2010 - 2011 Kevin Sylvestre
 */

(function ($) {
	
	$.growler = { options: { style: 'growls br' } };
	
	$.growler.growl = function(options) {
		
		var settings = {
      speed: 400,
			duration: 3200,
			opacity: 0.8,
			close: '&times;',
			style: 'default',
			size: 'medium',
			incoming: { opacity: 0.80 },
			outgoing: { opacity: 0.00 },
    };

	  var options = $.extend(settings, options);  
		
		var html = '<div id="growler" />';
    $('body:not(:has(#growler))').append(html);

		var $growler = $('#growler');
		$growler.attr('class', $.growler['options']['style']);

		var $growl = $('<div class="growl" />');
		
		$growl.attr('class', settings['style'] + ' growl ' + settings['size']);
		
		var $close   = $('<div class="close" />').html(options['close']);
		var $title   = $('<div class="title" />').html(options['title']);
		var $message = $('<div class="message" />').html(options['message']);
		
		$growl.append($close);
		$growl.append($title);
		$growl.append($message);
		
		$growl.css({ opacity: 0.0, position: "relative" });
		
		$growler.append($growl);
		
		$growl.present = function () { return this.animate(options.incoming, options.speed); };
		$growl.dismiss = function () { return this.animate(options.outgoing, options.speed); };
		
		$growl.present().delay(options.duration).dismiss();
		
		$close.click(function () {
			$growl.stop().dismiss();
		});
		
		return $growl;
		
	};
	
	$.growler.error = function(options) {
		
		var settings = {
			title: 'Error!',
			style: 'error',
		}
		
		return $.growler.growl($.extend(settings, options));
		
	};
	
	$.growler.notice = function(options) {
		
		var settings = {
			title: 'Notice!',
			style: 'notice',
		}
		
		return $.growler.growl($.extend(settings, options));
		
	};
	
	$.growler.warning = function(options) {
		
		var settings = {
			title: 'Warning!',
			style: 'warning',
		}
		
		return $.growler.growl($.extend(settings, options));
		
	};
    
}) (jQuery);