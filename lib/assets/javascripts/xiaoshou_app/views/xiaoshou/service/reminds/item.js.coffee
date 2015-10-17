class Mis.Views.XiaoshouServiceRemindsItem extends Backbone.View
  className: 'list_content'

  tagName: 'ul'

  template: JST['xiaoshou/service/reminds/item']

  initialize: ->
    @model.on("change", @render, @)

  events:
    'click input.editRemind': 'openRemindForm'

  render: ->
    @$el.html(@template(remind: @model))
    @

  openRemindForm: ->
    view = new Mis.Views.XiaoshouServiceRemindsForm(model: @model)
    view.open()
