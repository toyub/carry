class Mis.Views.XiaoshouServiceTrackingsForm extends Backbone.View
  el: '#trackingForm'

  template: JST['xiaoshou/service/trackings/form']

  initialize: (options) ->
    @store_service = @model.store_service
    @action = options.action

    @model.on('change', @addTracking, @)

  events:
    'click .closeWithoutSave': 'close'
    'click #saveTracking': 'saveTracking'

  render: ->
    @$el.html(@template(tracking: @model, view: @))
    @

  open: ->
    @render()
    @$el.show()

  close: ->
    @undelegateEvents()
    @$el.hide()

  saveTracking: ->
    @model.save @$el.find("input,select,textarea").serializeJSON()
    console.log @model
    @close()

  addTracking: ->
    @store_service.trackings.add @model

  isShow: ->
    @action == 'show'
