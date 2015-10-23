class Mis.Views.XiaoshouServiceRemindsForm extends Backbone.View
  el: '#remindForm'

  template: JST['xiaoshou/service/reminds/form']

  initialize: (options) ->
    @action = options.action

  events:
    'click .closeWithoutUpdate': 'close'
    'click #updateRemind': 'updateRemind'

  render: ->
    @$el.html(@template(remind: @model, view: @))
    @

  open: ->
    @render()
    @$el.show()

  close: ->
    @undelegateEvents()
    @$el.hide()

  updateRemind: ->
    @model.save @$el.find("input,select,textarea").serializeJSON()
    @close()

  isShow: ->
    @action == 'show'
