class Mis.ziDingYiView extends Backbone.View 
	template: JST["pos/zidingyi/zidingyi"]
	el: ".order_custom"

	initialize: ->
		@collection = new Mis.Collections.ZiDingYiMaterialCollection()
		@listenTo(@collection, "add", @addMaterialView)
		@render()

	events: 
		'click .new-material': 'newMaterial'
		'click .save-once': 'saveOnce'

	render: ->
		 @$el.html(@template())

  show: ->
     @$el.show()

  newMaterial: ->
  	@collection.add({})

  addMaterialView: (model) ->
    view = new Mis.addMaterialView(model: model)
    $(".list-new-material").append(view.render().el)

  saveOnce: ->
    @collection.saveAll
      success: (res) ->
        $('.save-once').hide()
      error: (res) ->
        alert res
