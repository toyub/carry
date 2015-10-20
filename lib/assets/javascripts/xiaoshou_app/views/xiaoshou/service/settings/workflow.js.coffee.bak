class Mis.Views.XiaoshouServiceSettingsWorkflow extends Backbone.View
  tagName: 'ul'

  className: 'items_content'

  template: JST['xiaoshou/service/settings/workflow']

  initialize: (options) ->
    @store_service = options.store_service
    @model.on('destroy', @remove, @)
    @model.on('change', @render, @)

  events:
    'click span.delete': 'clear'
    'click label.name': 'updateOnClick'

  render: ->
    @$el.html(@template(@model.attributes))
    @

  remove: ->
    @model.off()
    @undelegateEvents()
    @$el.remove()

  clear: ->
    @model.clear()

  updateOnClick: ->
    view = new Mis.Views.XiaoshouServiceSettingsWorkflowForm(view: @, collection: @collection, store_service: @store_service, model: @model)
    view.show()
    $('#create_workflow').hide()
