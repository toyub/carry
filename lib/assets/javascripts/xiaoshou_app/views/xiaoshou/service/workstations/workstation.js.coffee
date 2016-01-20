class Mis.Views.XiaoshouServiceWorkstationsWorkstation extends Mis.Base.View
  tagName: 'li'

  template: JST['xiaoshou/service/workstations/workstation']

  initialize: (options) ->
    @workflow = options.workflow
    @action = options.action

  events:
    'click input.checked': 'toggleChecked'

  render: ->
    @$el.html(@template(w: @model, workflow: @workflow, view: @))
    @

  toggleChecked: (event) ->
    if event.target.checked
      @workflow.workstations.add @model
    else
      @workflow.workstations.remove @model

  isShow: ->
    @action == 'show'
