class Mis.Views.XiaoshouUploadsTemplate extends Backbone.View
  className: 'goods_img'

  template: JST['xiaoshou/uploads/template']

  events:
    'click a.add_img': 'openImageForm'

  initialize: (options) ->
    @action = options.action if options

    @collection.on('add', @renderImage, @)

  render: ->
    @$el.html(@template(view: @))
    @renderImages()
    @

  openImageForm: ->
    view = new Mis.Views.XiaoshouUploadsForm()
    view.open()

  isShow: ->
    @action == 'show'

  renderImages: ->
    @collection.each @renderImage

  renderImage: (image) =>
    view = new Mis.Views.XiaoshouUploadsItem(model: image)
    @$("#preview_list").append view.render().el
