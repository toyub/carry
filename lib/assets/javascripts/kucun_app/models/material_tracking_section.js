(function(win, doc, Backbone, $$MIS){
  var contact_ways = ['短信', '微信'];
  var units = {minutes: '分钟',hours: '小时',days: '天',weeks: '周',months: '月',years: '年'};
  var MaterialTrackingSection = Backbone.Model.extend({
    defaults: {
      delay_unit: 'hours',
      timing: 0,
      contact_way: 0
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
      var delay_interval = this.get('delay_interval');
      var delay_unit = units[this.get('delay_unit')];
      return delay_interval + delay_unit;
    },

    content: function(){
      var _content = this.get('content');
      if(_content && _content.length > 11){
        _content = _content.slice(0, 11) + '...';
      }
      return _content;
    },

    contact_way: function(){
      return contact_ways[this.get('contact_way')];
    },

    attrs: function(){
      var _attrs = _.clone(this.attributes);
      console.log(_attrs)
      _attrs.cid = this.cid;
      _attrs.content = this.content();
      _attrs.contact_way_name = this.contact_way();
      _attrs.delay = this.delay();
      return _attrs;
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingSection = MaterialTrackingSection;
})(window, document, Backbone, window.$$MIS);
