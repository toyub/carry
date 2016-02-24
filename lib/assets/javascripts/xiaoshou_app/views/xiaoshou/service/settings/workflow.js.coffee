class Mis.Views.XiaoshouServiceSettingsWorkflow extends Mis.Base.View

  template: JST['xiaoshou/service/settings/workflow']

  render: ->
    @$el.html(@template(setting: @model, store: Mis.store))
    @renderWorkflows()
    @

  renderWorkflows: ->
    @model.workflows.each @renderWorkflow

  renderWorkflow: (workflow) =>
    view = new Mis.Views.XiaoshouServiceWorkflowsItem(model: workflow, action: 'show')
    @appendChildTo(view, @$("#workflow_list"))
