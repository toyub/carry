class Mis.Views.XiaoshouUploadsTemplate extends Backbone.View
  className: 'goods_img'

  template: JST['xiaoshou/uploads/template']

  events:
    'click a.add_img': 'openImageForm'

  initialize: (options) ->
    @action = options.action if options

  render: ->
    @$el.html(@template(view: @))
    @

  openImageForm: ->
    view = new Mis.Views.XiaoshouUploadsForm()
    view.open()

  isShow: ->
    @action == 'show'
