class Mis.Views.XiaoshouUploadsTemplate extends Backbone.View
  className: 'goods_img'

  template: JST['xiaoshou/uploads/template']

  events:
    'click a.add_img': 'openImageForm'

  render: ->
    @$el.html(@template())
    @

  openImageForm: ->
    view = new Mis.Views.XiaoshouUploadsForm()
    view.open()
