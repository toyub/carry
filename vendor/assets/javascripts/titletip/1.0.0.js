(function($) {
    $.fn.tooltip = function(options) {
        var defaults = {
            cssClass: "",
            delay: 2,
            duration: 500,
            opacity: 0,
            fadeDuration: 400,
            fixed: false
        };

        var options = $.extend(defaults, options);
        $tooltip = $("#divTooltip");
        if ($tooltip.length == 0) {
            $tooltip = $('<div id="divTooltip"></div>');
            $tooltip.hide();
            $('body').append($tooltip);
        }

        var left_c = function(window_with, document_scrollLeft, tooltip_with, target_x){
          var result = target_x;
          return result + tooltip_with > window_with + document_scrollLeft ? result - tooltip_with : result;
        };

        var top_c = function(window_height, document_scrollTop, tooltip_height, target_y, target_height){
          var result = target_y;
          return result + tooltip_height > window_height + document_scrollTop ? result - tooltip_height : result + target_height;
        }

        var show = function(evt) {
            evt = evt ? evt : window.event;
            var self = evt.target;
            var box = self.getBoundingClientRect();
            var $self = $(self);
            
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

            var target_height =  box.height;
            var target_x = evt.clientX;
            var target_y = box.top;

            $tooltip.css("left", left_c(window_with, document_scrollLeft, tooltip_with, target_x));
            $tooltip.css("top", top_c(window_height, document_scrollTop, tooltip_height, target_y, target_height));
            $tooltip.show();
        }

        var hide = function(evt) {
            evt = evt ? evt : window.event;
            var self = evt.target;
            var $self = $(self);
            $self.attr("title", $self.data("title"));
            $tooltip.fadeOut(options.fadeDuration);
        }

        return this.each(function(index) {
            var $this = $(this);
            $this.on('mouseenter', function(evt) {
                show(evt);
            });

            $this.mouseleave(function(evt) {
                hide(evt);
            });
        });
    }
})(jQuery);

jQuery(function($){
  $("[title]").tooltip({fixed: true});
});