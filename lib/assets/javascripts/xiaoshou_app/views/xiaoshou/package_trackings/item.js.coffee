class Mis.Views.XiaoshouPackageTrackingsItem extends Backbone.View
  tagName: 'ul'

  className: 'list_content'

  template: JST['xiaoshou/package_trackings/item']

  initialize: ->
    @model.on('change', @render, @)
    @model.on('destroy', @remove, @)

  events:
    'click label.content': 'openEditForm'
    'click span.delete': 'clear'

  render: ->
    @$el.html(@template(tracking: @model))
    @

  openEditForm: ->
    view = new Mis.Views.XiaoshouPackageTrackingsForm(model: @model)
    $("#trackingForm").html view.render().el
    view.open

  clear: ->
    @model.clear()

  remove: ->
    @undelegateEvents()
    @model.off()
    @$el.remove()
