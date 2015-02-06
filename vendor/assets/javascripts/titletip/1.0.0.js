(function($) {
    $.fn.tooltip = function(options) {
        var defaults = {
            cssClass: "",
            delay: 0,
            duration: 500,
            opacity: 0,
            fadeDuration: 400,
            eventshow: 'mouseover',
            eventhide: 'mouseleave',
            closebutton: 'no',
            fixed: false
        };

        var options = $.extend(defaults, options);
        var left_c = function(window_with, document_scrollLeft, tooltip_with, target_x){
          var result = target_x;
          return result + tooltip_with > window_with + document_scrollLeft ? result - tooltip_with : result;
        };

        var top_c = function(window_height, document_scrollTop, tooltip_height, target_y, target_height){
          var result = target_y;
          return result + tooltip_height > window_height + document_scrollTop ? result - tooltip_height : result + target_height;
        }

        return this.each(function(index) {
            var $this = $(this);
            $tooltip = $("#divTooltip");
            if ($tooltip.length == 0) {
                $tooltip = $('<div id="divTooltip"></div>');
                $('body').append($tooltip);
            }
            $tooltip.hide();

            function show(evt) {
                evt = evt ? evt : window.event;
                var self = evt.target;
                var $self = $(self);
                clearTimeout($tooltip.data("hideTimeoutId"));

                $tooltip.removeClass($tooltip.attr("class"));
                $tooltip.css("width", "");
                $tooltip.css("height", "");
                $tooltip.addClass(options.cssClass);
                $tooltip.css("opacity", 1 - options.opacity / 100);
                $tooltip.css("position", "absolute");
                
                $self.data("title", $self.attr("title"));
                $self.attr("title", "");
                $tooltip.html($self.data("title"));
                
                var window_with = $(window).width();
                var tooltip_with = $tooltip.width();
                var document_scrollLeft = $(document).scrollLeft();
                

                var window_height = $(window).height();
                var tooltip_height = $tooltip.height();
                var document_scrollTop = $(document).scrollTop();
                var target_height = self.offsetHeight;
                var target_x = evt.clientX;
                var target_y = self.scrollHeight + self.scrollTop +  self.offsetTop + self.offsetHeight;
                    target_y = evt.clientY;

                $tooltip.css("left", left_c(window_with, document_scrollLeft, tooltip_with, target_x));
                $tooltip.css("top", top_c(window_height, document_scrollTop, tooltip_height, target_y, target_height));

                $tooltip.data("showTimeoutId", setTimeout("$tooltip.fadeIn(" + options.fadeDuration + ")", options.delay));
            }


            $this.bind(options.eventshow, function(evt) {
                show(evt);
            });

            $tooltip.bind('mouseover', function(evt) {
                $this.stop();
                clearTimeout($tooltip.data("hideTimeoutId"));
            });

            $tooltip.bind('mouseleave', function(evt) {
                hide(evt);
            });

            function hide(evt) {
                evt = evt ? evt : window.event;
                var self = evt.target;
                var $self = $(self);
                $self.attr("title", $self.data("title"));
                clearTimeout($tooltip.data("showTimeoutId"));
                $tooltip.data("hideTimeoutId", setTimeout("$tooltip.fadeOut(" + options.fadeDuration + ")", options.duration));
            }

            $this.bind(options.eventhide, function(evt) {
                hide(evt);
            });
        });
    }
})(jQuery);

jQuery(function($){
  console.log($("[title]"))
  $("[title]").tooltip({fixed: true});
});