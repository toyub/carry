class Mis.Views.XiaoshouServiceRemindsForm extends Mis.Base.View
  className: 'new_reminder new_list'

  template: JST['xiaoshou/service/reminds/form']

  initialize: (options) ->
    @action = options.action

  events:
    'click .closeWithoutUpdate': 'close'
    'click #updateRemind': 'updateRemind'

  render: ->
    @$el.html(@template(remind: @model, view: @))
    @$el.show()
    @

  close: ->
    @leave()

  updateRemind: ->
    @model.save @$el.find("input,select,textarea").serializeJSON()
    @close()

  isShow: ->
    @action == 'show'
