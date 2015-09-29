class Mis.Views.XiaoshouServiceWorkflowsForm extends Backbone.View
  el: '#workflow_form'

  template: JST['xiaoshou/service/workflows/form']

  initialize: ->
    @store = window.Store

  events:
    'click #cancel_workflow': 'close'
    'click #save_workflow': 'addWorkflow'
    'click #delay_allowed': 'toggleDelayAllowed'
    'click #unlimited_mechanics': 'toggleEngineerCount'
    'click #nominate_station': 'showWorkstations'

  render: ->
    @$el.html(@template(workflow: @model, store: @store))
    @

  open: ->
    @render()
    @$el.show()

  close: ->
    @$el.hide()

  addWorkflow: ->
    @model.set @$el.find("input,select").serializeJSON().workflow
    console.log @model

  toggleDelayAllowed: (event) ->
    if $(event.target).attr('checked')
      @$(event.target).attr('checked', false)
    else
      @$(event.target).attr('checked', 'checked')

  toggleEngineerCount: (event) ->
    if @$(event.target).attr('checked')
      @$(event.target).attr('checked', false)
      @$("#limited_mechanics").attr("disabled", false)
    else
      @$(event.target).attr('checked', 'checked')
      @$("#limited_mechanics").attr("disabled", true)

  showWorkstations: ->
    @$("#nominated_stations").empty()
    @store.workstations.each @addWorkstation
    @$("#nominated_stations").show()

  addWorkstation: (workstation) =>
    view = new Mis.Views.XiaoshouServiceWorkstationsWorkstation(model: workstation)
    @$("#nominated_stations").append view.render().el
