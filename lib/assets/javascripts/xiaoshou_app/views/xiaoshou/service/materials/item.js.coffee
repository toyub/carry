class Mis.Views.XiaoshouServiceMaterialsItem extends Mis.Base.View
  className: "list_content list_tr"

  initialize: (options) ->
    @action = options.action
    @service = options.service
    @index = options.index

    @listenTo(@model, 'remove', @leave)

  events:
    'click span.delete': 'clear'
    'click label.showMaterial': 'showMaterial'

  template: JST['xiaoshou/service/materials/item']

  render: ->
    @$el.html(@template(_.extend(@model.attributes, {view: @})))
    @

  isEdit: ->
    @action == 'edit'

  clear: ->
    @service.materials.remove @model

  showMaterial: ->
    view = new Mis.Views.XiaoshouServiceMaterialsShow(model: @model)
    $("#show_server").html view.render().el
    $("#show_server").show()
