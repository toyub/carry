(function(win, doc, Backbone, $$MIS){
  var MaterialTrackingSection = Backbone.Model.extend({
    defaults: {
      delay_unit: 'hour',
      timing: 1,
      contact_way: 1
    },

    validate: function(attrs, options){
      if(!attrs.delay){
        return '请填写回访时间,回访时间必须是大于零的数字';
      }else{
        if(attrs.delay < 1){
          return '回访时间必须是大于零的数字';
        }
      }
      
      if(!attrs.content){
        return '请填写回访内容';
      }

    },

    delay: function(){
      var _delay = this.get('delay_in_seconds');
      var d1 = new Date(2000, 0, 1, 0, 0, _delay);
      var d2 = new Date(2000, 0, 1, 0, 0, 0);
      var year = d1.getFullYear() - d2.getFullYear();
      var month = d1.getMonth() - d2.getMonth();
      var day = d1.getDate() - d2.getDate();
      var hour = d1.getHours() - d2.getHours();
      var str = "";
      if(year > 0){
        str = str + year + '年';
      }
      if(month > 0){
        str = str + month + '月';
      }
      if(day > 0){
        str = str + day + '日';
      }
      if(hour > 0){
        str = str + hour + '时';
      }
      return str;
    },
    content: function(){
      var _content = this.get('content');
      if(_content.length > 11){
        _content = _content.slice(0, 11) + '...';
      }
      return _content;
    },
    is_new_record: function(){
      return this._saved == 1;
    },
    commit: function(){
      if(!this._saved){
        this._saved = 1;
      }else{
        this._saved++;
      }
    }
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.MaterialTrackingSection = MaterialTrackingSection;
})(window, document, Backbone, window.$$MIS);
