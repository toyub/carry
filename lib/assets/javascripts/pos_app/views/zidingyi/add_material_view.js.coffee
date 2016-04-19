class Mis.addMaterialView extends Backbone.View
  template: JST["pos/zidingyi/add_material"]

  tagName: "tr"

  render: ->
    @$el.html(@template(@model.toJSON() ))
    @$el.addClass(@model.cid)
    @

