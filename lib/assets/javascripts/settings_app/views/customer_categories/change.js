(function(win, doc, Backbone, $$MIS){
  var tmpl = JST['settings/customer_categories/change'];
  var ChangeCustomerCategoriesView = Backbone.View.extend({
    tagName: 'div',
    className: 'batch_convert',
    initialize: function(opt){
      this.customers = opt.customers;
      this.categories = opt.categories;
    },
    events: {
      'click .batch_convert_btn': 'batch_convert',
      'click .select_all_btn':'toggle_all'
    },
    render: function(){
      var x = {
        category: this.model.attributes,
        customers: this.customers,
        categories: this.categories
      }

      this.$el.html(tmpl(x));
      return this.$el;
    },
    batch_convert: function(){
      var ids = this.$el.find('input.customer_id:checked').map(function(idx, input){return input.value}).toArray();
      var _this = this;
      if(ids.length < 1){
        alert('请先选择要转移的客户！');
        return false;
      }
      var dest_category_id = this.$el.find('select.dest').val();
      if(!dest_category_id){
        alert('请先选择目标类别');
        return false;
      }
      $.ajax({
        type: "POST",
        url: '/settings/customer_categories/'+ dest_category_id +'/change_category',
        data: {customers_ids: ids},
        success: function(data){
          ids.forEach(function(id, idx){
            _this.$el.find('ul[data-id='+ id+']').remove();
          });
          if(_this.$el.find('ul.customer').length < 1){
            _this.$el.find('.list_content').html('分类下的客户已经转移完毕');
            _this.$el.find('.operate_content').hide();
          }
        },
        error: function(){
          alert('网络错误，请重试');
        }
      });
    },
    toggle_all: function(evt){
      var checked_all_btn = evt.target;
      if(checked_all_btn.checked){
        this.$el.find('input.customer_id').prop('checked', true);
      }else{
        this.$el.find('input.customer_id').removeAttr('checked');
      }
    }
  });

  win.$$MIS = $$MIS || {};
  win.$$MIS.ChangeCustomerCategoriesView = ChangeCustomerCategoriesView;
})(window, document, Backbone, window.$$MIS);
