class Mis.Views.XiaoshouServiceWorkstationsWorkstation extends Backbone.View
  tagName: 'li'

  template: JST['xiaoshou/service/workstations/workstation']

  initialize: (options) ->
    @workflow = options.workflow

  events:
    'click input.checked': 'toggleChecked'

  render: ->
    @$el.html(@template(w: @model, workflow: @workflow))
    @

  toggleChecked: (event) ->
    if event.target.checked
      @workflow.workstations.add @model
    else
      @workflow.workstations.remove @model
