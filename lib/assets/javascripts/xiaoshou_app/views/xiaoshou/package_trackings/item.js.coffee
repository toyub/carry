class Mis.Views.XiaoshouPackageTrackingsItem extends Backbone.View
  tagName: 'ul'

  className: 'list_content'

  template: JST['xiaoshou/package_trackings/item']

  initialize: (options) ->
    @action = options.action if options

    @model.on('change', @render, @)
    @model.on('destroy', @remove, @)

  events:
    'click label.content': 'showOrEdit'
    'click span.delete': 'clear'

  render: ->
    @$el.html(@template(tracking: @model, view: @))
    @

  showOrEdit: ->
    if @isShow()
      view = new Mis.Views.XiaoshouPackageTrackingsFormShow(model: @model)
    else
      view = new Mis.Views.XiaoshouPackageTrackingsForm(model: @model)
    $("#trackingForm").html view.render().el
    view.open

  clear: ->
    @model.clear()

  remove: ->
    @undelegateEvents()
    @model.off()
    @$el.remove()

  isShow: ->
    @action == 'show'
