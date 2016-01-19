(function(win, $){
  var tmpl = function(idx, damage){
    return '<li>' + idx + ':<input type="text" class="width-150" name="situation[damages][][content]" placeholder="损坏情况描述" value="' + damage.content + '"></li>';
  }
  var situation = {
    fuel_gauge: 0,
    mileage: 0,
    damages: [{part_id: 1, content: '大灯坏了'}, {part_id: 14, content: 'Olosdfj sd'}]
  }

  function VehicleSituation(el){
    this.$el =  $(el);
    var _this = this;
    situation.damages.forEach(function(damage, idx){
      _this.$el.find('#situation_damages').append(tmpl(idx+1, damage));
      _this.$el.find('.js-part'+damage.part_id).attr('checked', true);
    });
  }

  win.Mis.Vues.VehicleSituation = VehicleSituation;
})(window, jQuery);
