(function(win, doc, Backbone, $$MIS){
  var detail_tmpl = JST['kucun/commissions/new/detail'];
  views = {};
  services = [];
  var SaleinfoHandleView = Backbone.View.extend({
    el: 'body',
    events:{
      'change input[name="saleinfo[volume]"], select[name="saleinfo[unit]"]': 'calc_cost',
      'change input[name="saleinfo[service_needed]"]': 'toggle_btn',
      'change [name="saleinfo[service_fee_needed]"]': 'change_fee_enable',
      'click .detail': 'show_commission_template',
      'click #add_server_btn': 'add_service',
      'submit #saleinfo_form': 'save',
      'click .do_edit': 'edit_service'
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
    },
    add_service: function(evt){
      var target = evt.target;
      if(target.classList.contains('disabled')){
        return false;
      }
      target.classList.add('disabled');
      
      var service_view = new $$MIS.SaleinfoServiceView({
        model: new $$MIS.SaleinfoService()
      });
      service_view.idx = $('#lists').find('.list_content').length + 1;
      service_view.store_commission_templates = this.store_commission_templates;
      $('div.server_list').append(service_view.render().el);
      views[service_view.cid] = service_view;

    },
    edit_service: function(evt){

      var target = evt.target;
      $('#add_server_btn').addClass('disabled');
      if(target.dataset.viewid){
        var service_view = views[target.dataset.viewid];
      }else{
        var model = collection.find(function(model){return model.get('id') == target.dataset.id})
        var service_view = new $$MIS.SaleinfoServiceView({
          model: model
        });
        service_view.summary_el = $(target.parentNode.parentNode);
        views[service_view.cid] = service_view;
        service_view.idx = $('#lists').find('.list_content').length + 1;
        service_view.store_commission_templates = this.store_commission_templates;
        $('div.server_list').append(service_view.render().el);
        
      }
      
      
      service_view.$el.show();
    },
    save: function(evt){

        evt.preventDefault();
        var formdata = $(this).serializeJSON();
        formdata.saleinfo.services_attributes = services.map(function(model, idx, collection, undef){
          return model.form_attrs();
        });
        return false;
    },
    create: function(){
      $.ajax({
          url: form_url,
          dataType: 'json',
          type : 'POST',
          contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
          data: formdata,
          success:function(data){
            window.location.replace('/kucun/materials/<%= @store_material.id %>/saleinfo')
          },
          error: function(){
            ZhanchuangAlert('系统错误，请重试。');
          }
        })
    },
    update: function(){

    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoHandleView = SaleinfoHandleView;
})(window, document, Backbone, window.$$MIS);
