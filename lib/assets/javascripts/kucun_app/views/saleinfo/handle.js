(function(win, doc, Backbone, $$MIS){
  var SaleinfoHandleView = Backbone.View.extend({
    el: 'body',
    initialize: function(options){
      this.urlRoot = options.urlRoot;
      this.services = new $$MIS.SaleinfoServiceCollection();
      this.services.url = options.urlRoot + '/saleinfo_services';
      this.services.fetch();
      this.listenTo(this.services, 'add', this.add_summary)
    },
    events:{
      'change input[name="saleinfo[volume]"], select[name="saleinfo[unit]"]': 'calc_cost',
      'change input[name="saleinfo[service_needed]"]': 'toggle_btn',
      'change [name="saleinfo[service_fee_needed]"]': 'change_fee_enable',
      'click .detail': 'show_commission_template',
      'click #add_server_btn': 'add_service',
      'submit #saleinfo_form': 'save'
    },

    calc_cost: function(){
      var volume = $("input[name='saleinfo[volume]']")[0];
      var unit_select = $("select[name='saleinfo[unit]'")[0];
      var unit = unit_select.options[unit_select.selectedIndex].textContent;
      $('#divided_cost').val((volume.dataset.costprice / volume.value).toFixed(2) + '元/' + unit);
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

    add_summary: function(model, collection, ajax,udef){
      var summary_view = new $$MIS.SaleinfoServiceSummaryView({model: model});
      summary_view.idx = $("#lists").children('.list_content').length + 1;
      $("#lists").append(summary_view.render());
      $("#lists").show();
      $('#services').show();
      var _this = this;
      summary_view.on('edit', function(){
        _this.edit_service(this.model);
      });
    },

    add_service: function(evt){
      var target = evt.target;
      var _this = this;
      if(target.classList.contains('disabled')){
        ZhanchuangAlert("请先开启服务选项!");
        return false;
      }
      target.classList.add('disabled');

      var service_view = new $$MIS.SaleinfoServiceView({
        model: new $$MIS.SaleinfoService()
      });
      service_view.idx = $('#lists').find('.list_content').length + 1;
      service_view.store_commission_templates = this.store_commission_templates;
      $('div.server_list').append(service_view.render().el);
      service_view.on('created', function(){
        _this.services.add(service_view.model);
      });
    },

    edit_service: function(model){
      if($('#add_server_btn').hasClass('disabled')){
        ZhanchuangAlert("请先开启服务选项!");
        return false;
      }
      $('#add_server_btn').addClass('disabled');
      var service_view = new $$MIS.SaleinfoServiceView({
        model: model
      });
      service_view.idx = $('#lists').find('.list_content').length + 1;
      service_view.store_commission_templates = this.store_commission_templates;
      $('div.server_list').append(service_view.render().el);
    },

    save: function(evt){
      evt.preventDefault();
      var target = evt.target;
      var formdata = $(target).serializeJSON({checkboxUncheckedValue: 'false', parseBooleans: true});
      formdata.saleinfo.services_attributes = this.services.map(function(model, idx, collection, undef){
        return model.form_attrs();
      });
      if(!!formdata.saleinfo.id){
        this.update(formdata);
      }else{
        this.create(formdata);
      }
      return false;
    },

    create: function(formdata){
      var _this = this;
      $.ajax({
          url: _this.urlRoot,
          dataType: 'json',
          type : 'POST',
          contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
          data: formdata,
          success:function(data){
            ZhanchuangAlert('保存成功');
          },
          error: function(){
            ZhanchuangAlert('系统错误，请重试。');
          }
        });
    },
    update: function(formdata){
      var _this = this;
      $.ajax({
          url: _this.urlRoot,
          dataType: 'json',
          type : 'PUT',
          contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
          data: formdata,
          success:function(data){
            ZhanchuangAlert('保存成功');
          },
          error: function(){
            ZhanchuangAlert('系统错误，请重试。');
          }
        });
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.SaleinfoHandleView = SaleinfoHandleView;
})(window, document, Backbone, window.$$MIS);
