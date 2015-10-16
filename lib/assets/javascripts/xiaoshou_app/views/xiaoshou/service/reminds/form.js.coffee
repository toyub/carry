class Mis.Views.XiaoshouServiceRemindsForm extends Backbone.View
  el: '#remindForm'

  template: JST['xiaoshou/service/reminds/form']

  events:
    'click #closeWithoutUpdate': 'close'
    'click #updateRemind': 'updateRemind'

  render: ->
    @$el.html(@template(remind: @model))
    @

  open: ->
    @render()
    @$el.show()

  close: ->
    @undelegateEvents()
    @$el.hide()

  updateRemind: ->
    @model.set @$el.find("input,select,textarea").serializeJSON()
    @model.save()
    @close()
    console.log @model
    console.log @model.url()
