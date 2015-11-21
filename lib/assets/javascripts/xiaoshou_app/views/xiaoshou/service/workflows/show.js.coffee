class Mis.Views.XiaoshouServiceWorkflowsShow extends Backbone.View
  el: '#workflow_form'

  template: JST['xiaoshou/service/workflows/show']

  events:
    'click #closeShow': 'close'

  render: ->
    @$el.html(@template(workflow: @model, store: Mis.store))
    @

  open: ->
    @render()
    @$el.show()

  close: ->
    @undelegateEvents()
    @$el.hide()

