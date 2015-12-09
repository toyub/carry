class Mis.Views.XiaoshouPackageTrackingsItem extends Mis.Base.View
  tagName: 'ul'

  className: 'list_content'

  template: JST['xiaoshou/package_trackings/item']

  initialize: (options) ->
    @action = options.action if options

    @listenTo(@model, 'change', @render)
    @listenTo(@model, 'destroy', @leave)

  events:
    'click label.content': 'showOrEdit'
    'click span.delete': 'clear'

  render: ->
    @$el.html(@template(tracking: @model, view: @))
    @

  showOrEdit: ->
    if @isShow()
      view = new Mis.Views.XiaoshouPackageTrackingsFormShow(model: @model)
    else
      view = new Mis.Views.XiaoshouPackageTrackingsForm(model: @model)
    @renderChild(view)
    $("#trackingForm").html view.el

  clear: ->
    @model.clear()

  isShow: ->
    @action == 'show'
