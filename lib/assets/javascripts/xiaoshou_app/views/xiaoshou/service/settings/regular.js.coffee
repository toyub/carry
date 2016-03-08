class Mis.Views.XiaoshouServiceSettingsRegular extends Mis.Base.View

  template: JST['xiaoshou/service/settings/regular']

  render: ->
    @$el.html(@template(setting: @model, store: Mis.store))
    @renderWorkstations()
    @

  renderWorkstations: ->
    @$("#stations").empty()
    Mis.store.workstations.each @addWorkstation

  addWorkstation: (workstation) =>
    view = new Mis.Views.XiaoshouServiceWorkstationsWorkstation(workflow: @model, model: workstation, action: 'show')
    @appendChildTo(view, @$("#stations"))
