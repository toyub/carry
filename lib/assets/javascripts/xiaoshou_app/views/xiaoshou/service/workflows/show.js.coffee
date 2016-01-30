class Mis.Views.XiaoshouServiceWorkflowsShow extends Mis.Base.View
  className: 'new_process_details new_items_details do_list_new_page'

  template: JST['xiaoshou/service/workflows/show']

  events:
    'click #closeShow': 'close'

  render: ->
    @$el.html(@template(workflow: @model, store: Mis.store))
    @renderWorkstations()
    @$el.show()
    @

  renderWorkstations: ->
    @$("#nominated_stations").empty()
    Mis.store.workstations.each @addWorkstation

  close: ->
    @leave()

  addWorkstation: (workstation) =>
    view = new Mis.Views.XiaoshouServiceWorkstationsWorkstation(workflow: @model, model: workstation, action: 'show')
    @appendChildTo(view, @$("#nominated_stations"))
