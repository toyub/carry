class Mis.Views.XiaoshouServiceRemindsItem extends Backbone.View
  className: 'list_content'

  tagName: 'ul'

  template: JST['xiaoshou/service/reminds/item']

  initialize: (options) ->
    @action = options.action

    @model.on("change", @render, @)

  events:
    'click input.editRemind': 'openRemindForm'

  render: ->
    @$el.html(@template(remind: @model))
    @

  openRemindForm: ->
    view = new Mis.Views.XiaoshouServiceRemindsForm(model: @model, action: @action)
    view.open()
