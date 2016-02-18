class Mis.Views.XiaoshouServiceWorkflowsForm extends Mis.Base.View
  className: 'new_process_details new_items_details do_list_new_page'

  template: JST['xiaoshou/service/workflows/form']

  initialize: (options) ->
    @store = Mis.store
    @setting = options.setting

  events:
    'click #cancel_workflow': 'close'
    'click #save_workflow': 'saveWorkflow'
    'click #delay_allowed': 'toggleDelayAllowed'
    'click #unlimited_mechanics': 'toggleEngineerCount'
    'click #nominate_station': 'showWorkstations'
    'click #random_station_in_process': 'hideWorkstations'

  render: ->
    @$el.html(@template(workflow: @model, store: @store))
    @renderWorkstations()
    @$el.show()
    @

  close: =>
    @leave()

  saveWorkflow: ->
    @model.set @$el.find("input,select").serializeJSON().workflow
    @setting.workflows.add @model
    @close()

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
    @appendChildTo(view, @$("#nominated_stations"))
