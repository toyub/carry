class Mis.Views.XiaoshouServiceWorkstationsCategory extends Backbone.View

  template: JST['xiaoshou/service/workstations/category']

  initialize: (options) ->
    @setting = options.setting

  events:
    'click li.category': 'getWorkstations'

  render: ->
    @$el.html(@template(@model.attributes))
    @

  getWorkstations: ->
    $("#getWorkstationCategory").text(@model.get 'name')
    $("#storeWorkstations").empty()
    @model.workstations.each @addWorkstation
    $("#storeWorkstations").show()
    $("#workstationCategories").hide()

  addWorkstation: (workstation) =>
    view = new Mis.Views.XiaoshouServiceWorkstationsItem(model: workstation, setting: @setting)
    $("#storeWorkstations").append view.render().el
