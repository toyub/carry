class Mis.ziDingYiView extends Backbone.View 
	template: JST["pos/zidingyi/zidingyi"]
	el: ".order_custom"

	initialize: ->
		@collection = new Mis.ZiDingYiMaterialCollection()
		@listenTo(@collection, "add", @add_material_view)
		@render()

	events: 
		'click .new-material': 'newMaterial'

	render: ->
		 @$el.html(@template())

  show: ->
     @$el.show()

  newMaterial: ->
  	@collection.add({})

  add_material_view: (model) ->
  	@view = new Mis.addMaterialView({model: model})
  	$(".list-new-material").append(@view.render().el)

