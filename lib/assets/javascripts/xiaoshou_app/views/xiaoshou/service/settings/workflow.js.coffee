class Mis.Views.XiaoshouServiceSettingsWorkflow extends Backbone.View

  template: JST['xiaoshou/service/settings/workflow']

  render: ->
    @$el.html(@template())
    @renderWorkflows()
    @

  renderWorkflows: ->
    @model.workflows.each @renderWorkflow

  renderWorkflow: (workflow) =>
    view = new Mis.Views.XiaoshouServiceWorkflowsItem(model: workflow, action: 'show')
    @$("#workflow_list").append view.render().el
