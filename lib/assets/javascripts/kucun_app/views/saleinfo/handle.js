(function(win, doc, Backbone, $$MIS){
  var detail_tmpl = JST['kucun/commissions/new/detail'];
  var SaleinfoHandleView = Backbone.View.extend({
    el: 'body',
    events:{
      'change input[name="saleinfo[volume]"], select[name="saleinfo[unit]"]': 'calc_cost',
      'change input[name="saleinfo[service_needed]"]': 'toggle_btn',
      'change [name="saleinfo[service_fee_needed]"]': 'change_fee_enable',
      'click .detail': 'show_commission_template'
    },

    calc_cost: function(){
      var volume = $("input[name='saleinfo[volume]']")[0];
      var unit = $("select[name='saleinfo[unit]'");
      $('#divided_cost').val((volume.dataset.costprice / volume.value).toFixed(2) + '元/' + unit.val());
    },
    toggle_btn: function(evt){
      var target = evt.target;
      if(target.checked){
        $('#add_server_btn').removeClass('disabled');
      }else{
        $('#add_server_btn').addClass('disabled');
      }
    },
    change_fee_enable: function(evt){
      var target = evt.target;
      if(target.dataset.target){
        $("[name='saleinfo[service_fee]']").removeAttr('disabled');
       }else{
        $("[name='saleinfo[service_fee]']").attr('disabled', true);
       }
    },
    show_commission_template: function(evt){
      var target = evt.target;
      var select = $(target).siblings('select')[0];
        if(select.value){
            var data = $(select.options[select.selectedIndex]).data('template');
            $("#commission_tempalte_detail").html(detail_tmpl(data)).show();
        }else{
          ZhanchuangAlert('请选择一个方案');
        }
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoHandleView = SaleinfoHandleView;
})(window, document, Backbone, window.$$MIS);
