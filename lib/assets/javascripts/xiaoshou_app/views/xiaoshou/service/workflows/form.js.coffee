class Mis.Views.XiaoshouServiceWorkflowsForm extends Backbone.View
  el: '#workflow_form'

  template: JST['xiaoshou/service/workflows/form']

  initialize: (options) ->
    @store = Mis.store
    @setting = options.setting

  events:
    'click #cancel_workflow': 'close'
    'click #save_workflow': 'addWorkflow'
    'click #delay_allowed': 'toggleDelayAllowed'
    'click #unlimited_mechanics': 'toggleEngineerCount'
    'click #nominate_station': 'showWorkstations'
    'click #random_station_in_process': 'hideWorkstations'

  render: ->
    @$el.html(@template(workflow: @model, store: @store))
    @renderWorkstations()
    @

  open: ->
    @render()
    @$el.show()

  close: =>
    @undelegateEvents()
    @$el.hide()

  addWorkflow: ->
    @model.set @$el.find("input,select").serializeJSON().workflow
    console.log @model
    @setting.workflows.add @model
    @close()
    console.log @setting

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

  renderWorkstations: ->
    @$("#nominated_stations").empty()
    @store.workstations.each @addWorkstation

  showWorkstations: ->
    @$("#nominated_stations").show()

  hideWorkstations: ->
    @$("#nominated_stations").hide()

  addWorkstation: (workstation) =>
    view = new Mis.Views.XiaoshouServiceWorkstationsWorkstation(workflow: @model, model: workstation)
    @$("#nominated_stations").append view.render().el
