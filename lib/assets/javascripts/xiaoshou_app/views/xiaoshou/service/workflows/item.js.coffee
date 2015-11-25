class Mis.Views.XiaoshouServiceWorkflowsItem extends Mis.Base.View
  className: 'items_content'

  tagName: 'ul'

  template: JST['xiaoshou/service/workflows/item']

  initialize: (options) ->
    @setting = options.setting
    @action = options.action

    @listenTo(@model, 'remove', @leave)
    @listenTo(@model, 'change', @render)

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

  editOrShow: ->
    if @isEdit()
      view = new Mis.Views.XiaoshouServiceWorkflowsForm(model: @model, setting: @setting)
    else
      view = new Mis.Views.XiaoshouServiceWorkflowsShow(model: @model)
    @parent.appendChildTo(view, @parent.$(".j_workflow_setting"))
