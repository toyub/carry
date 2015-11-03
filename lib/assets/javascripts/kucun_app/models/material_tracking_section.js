(function(win, doc, Backbone, $$MIS){
  var MaterialTrackingSection = Backbone.Model.extend({
    defaults: {
      delay_unit: 'hours',
      timing: 1,
      contact_way: 1
    },

    validate: function(attrs, options){
      if(!attrs.delay_interval){
        return '请填写回访时间,回访时间必须是大于零的数字';
      }else{
        if(attrs.delay_interval < 1){
          return '回访时间必须是大于零的数字';
        }
      }

      if(!attrs.content){
        return '请填写回访内容';
      }

    },

    delay: function(){
      return human_readable_time(this.get('delay_in_seconds'));
    },
    content: function(){
      var _content = this.get('content');
      if(_content && _content.length > 11){
        _content = _content.slice(0, 11) + '...';
      }
      return _content;
    },
    attrs: function(){
      var _attrs = _.clone(this.attributes);
      _attrs.cid = this.cid;
      _attrs.content = this.content();
      _attrs.delay = this.delay();
      return _attrs;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingSection = MaterialTrackingSection;
})(window, document, Backbone, window.$$MIS);
