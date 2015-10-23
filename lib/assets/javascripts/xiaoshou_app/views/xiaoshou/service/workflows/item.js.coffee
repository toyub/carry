class Mis.Views.XiaoshouServiceWorkflowsItem extends Backbone.View
  className: 'items_content'

  tagName: 'ul'

  template: JST['xiaoshou/service/workflows/item']

  initialize: (options) ->
    @setting = options.setting
    @action = options.action

    @model.on('remove', @remove, @)
    @model.on('change', @render, @)

  events:
    'click span.delete': 'clear'
    'click label.name': 'editOrShow'

  render: ->
    @$el.html(@template(_.extend(@model.attributes, {view: @})))
    @

  isEdit: ->
    @action == 'edit'

  clear: ->
    @setting.workflows.remove @model

  remove: ->
    @model.off()
    @undelegateEvents()
    @$el.remove()

  editOrShow: ->
    if @isEdit()
      view = new Mis.Views.XiaoshouServiceWorkflowsForm(model: @model, setting: @setting)
    else
      view = new Mis.Views.XiaoshouServiceWorkflowsShow(model: @model)
    view.open()
