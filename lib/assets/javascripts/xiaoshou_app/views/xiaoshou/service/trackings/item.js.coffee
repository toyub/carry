class Mis.Views.XiaoshouServiceTrackingsItem extends Mis.Base.View

  tagName: 'ul'

  className: 'tracking_list_content list_content'

  template: JST['xiaoshou/service/trackings/item']

  initialize: (options) ->
    @action = options.action

    @listenTo(@model, 'change', @render)
    @listenTo(@model, 'destroy', @leave)

  events:
    'click label.content': 'editTracking'
    'click span.delete': 'clear'

  render: ->
    @$el.html(@template(tracking: @model, view: @))
    @

  editTracking: ->
    view = new Mis.Views.XiaoshouServiceTrackingsForm(model: @model, action: @action)
    @parent.appendChildTo(view, @parent.$(".tracking_list"))

  clear: ->
    @model.clear()

  isShow: ->
    @action == 'show'
