(function(win, $){
  var tmpl = function(idx, damage){
    return '<li>' + idx + ':<input type="text" data-partid="' + damage.part_id +'" class="width-150" name="situation[damages][][content]" placeholder="损坏情况描述" value="' + damage.content + '"></li>';
  }
  
  function Situation(opt){
    var defaults = {
      fuel_gauge: 0,
      mileage: 0,
      damages: []
    };
    this.attributes = $.extend(defaults, opt);
    if(!this.attributes.damages){
      this.attributes.damages = [];
    }
  }

  Situation.prototype = {
    constructor: Situation,
    damaged: function(part_id){
      return !this.attributes.damages.every(function(damage){return damage.part_id != part_id});
    },

    the_damage: function(part_id){
      return this.attributes.damages.find(function(damage){
        return damage.part_id == part_id;
      });
    },
    remove_damamge: function(part_id){
      this.attributes.damages = this.attributes.damages.filter(function(damage){
        return damage.part_id != part_id;
      });
    },
    add_damage: function(part_id){
      this.attributes.damages.push({part_id: part_id, content: ''});
    }
  }

  function VehicleSituation(el, situation){
    this.$el = $(el);
    this.situation = new Situation(situation);
    this.render();
    var _this = this;
    this.$el.on('click', '.checktoggle', function(evt){
      if(this.checked){
        if(!_this.situation.damaged(this.value)){
          _this.situation.add_damage(this.value)
        }
      }else{
        if(_this.situation.damaged(this.value)){
          _this.situation.remove_damamge(this.value);
        }
      }
      _this.rerender();
    });

    this.$el.on('change', '[name="situation[damages][][content]"]', function(){
      _this.situation.the_damage(this.dataset.partid).content = this.value;
    });
  }

  VehicleSituation.prototype = {
    constructor: VehicleSituation,
    render: function(){
      var _this = this;
      var situation = this.situation.attributes;
      _this.$el.find('#situation_damages').html('');
      _this.$el.find('.checktoggle').attr('checked', false);
      _this.$el.find('#fuel_gauge').val(situation.fuel_gauge);
      _this.$el.find('[name="fuel_gauge_volume"]').val(situation.fuel_gauge);
      _this.$el.find('#mileage').val(situation.mileage);
      situation.damages.forEach(function(damage, idx){
        _this.$el.find('#situation_damages').append(tmpl(idx+1, damage));
        _this.$el.find('.js-part'+damage.part_id).attr('checked', true);
      });
    },
    rerender: function(){
      var _this = this;
      var situation = this.situation.attributes;
      _this.$el.find('#situation_damages').html('');
      situation.damages.forEach(function(damage, idx){
        _this.$el.find('#situation_damages').append(tmpl(idx+1, damage));
      });
    },
    damages: function(){
      return $('[name="situation[damages][][content]"').map(function(idx, el){return ({part_id: el.dataset.partid, content: el.value})}).toArray();
    },
    get_situation: function(){
      return {
        fuel_gauge: this.$el.find('#fuel_gauge').val(),
        mileage: this.$el.find('#mileage').val(),
        damages: this.situation.attributes.damages
      };
    },
    set_situation: function(situation){
      this.situation = new Situation(situation);
      this.render();
    }
  }

  win.Mis.Vues.VehicleSituation = VehicleSituation;
})(window, jQuery);
