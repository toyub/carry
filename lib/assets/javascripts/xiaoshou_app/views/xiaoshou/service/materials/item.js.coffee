class Mis.Views.XiaoshouServiceMaterialsItem extends Backbone.View
  className: "list_content list_tr"

  initialize: (options) ->
    @action = options.action
    @service = options.service

    @model.on('remove', @remove, @)

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

  remove: ->
    @model.off()
    @undelegateEvents()
    @$el.remove()

  showMaterial: ->
    view = new Mis.Views.XiaoshouServiceMaterialsShow(model: @model)
    view.open()
