(function(win, doc, Backbone, $$MIS){
  var summary_tmpl = JST['settings/depots/new/summary'];
  var DepotSummaryView = Backbone.View.extend({
    tagName: 'tr',
    events: {
      'click .edit_warehouse': 'edit',
      'click .useable': 'toggle_useable',
      'click .preferred.not_default': 'prefer',
      'click .delete_warehouse': 'delete'
    },
    initialize: function(opt){
      this.model = opt.model;
      this.staff = opt.staff;
      this.listenTo(this.model, "change", this.refresh);
    },
    render: function(){
      var _attrs = this.model.summary_attrs();
      var admin_ids = this.model.admin_ids();
      _attrs.admins = this.staff
                          .filter(function(staff,idx,arr){return admin_ids.indexOf(staff.id) > -1;})
                          .map(function(staff, idx, arr){
                            return staff.full_name;
                          });
      this.$el.html(summary_tmpl(_attrs));
      return this.$el;
    },

    edit: function(){
      if($('input.new_btn').hasClass('disabled')){
        return false;
      }
      this.trigger('edit');
    },

    refresh: function(){
      this.render();
    },
    toggle_useable: function(){
      if(this.model.get('useable') && this.model.get('preferred')){
        ZhanchuangAlert('不能停用默认仓库，请先设置其他仓库为默认仓库后再停用！');
        return false;
      }

      if(this.model.get('useable')){
        var _this = this;
        $.get(this.model.url() + "/binding_material_count").success(function(data){
          if(data.bound > 0){
            $('#bound_count').html(data.bound);
            $('#transfer_link').attr('href', "/kucun/transfer/pickings/new?depot_id=" + _this.model.get('id'));
            $('#bound_alert').show();
          }else{
            if(confirm('是否确定停用此仓库(库名：' + _this.model.get('name') +')')){
              _this.model.toggle_useable(false);
            }
          }
        })
        .error(function(){
          ZhanchuangAlert("系统错误，请重试!");
        })
      }else{
        this.model.toggle_useable(true);
      }
    },

    prefer: function(){
      if(!this.model.get('useable')){
        ZhanchuangAlert('不能将已经停止使用的仓库设置为默认仓库！');
        return false;
      }
      var current_default = this.model.collection.current_default();
      if(current_default){
        current_default.prefer(false);
      }
      this.model.prefer(true);
    },

    delete: function(){
      var _this = this;
      if(this.model.get('useable')){
        ZhanchuangAlert('不能删除正在使用中的仓库！');
        return false;
      }
      if(confirm("仓库删除后无法恢复，是否确定删除？")){
        this.model
          .destroy({
            error: function(model, response, ajax, undef){
              if(ajax.xhr.status == 409){
                ZhanchuangAlert(response.responseJSON.error);
              }else if(ajax.xhr.status == 200){
                _this.trigger('deleted');
              }else{
                ZhanchuangAlert("操作未成功，请重试!");
              }
          },
          success: function(model, response_json, ajax, undef){
            _this.trigger('deleted');
          }
        });
      }
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.DepotSummaryView = DepotSummaryView;
})(window, document, Backbone, window.$$MIS);
