class Mis.Views.XiaoshouPackageItemsPackageItem extends Mis.Base.View
  tagName: 'ul'

  className: 'items_content'

  template: JST['xiaoshou/package_items/package_item']

  initialize: (options) ->
    @action = options.action if options
    @package_setting = options.package_setting
    @index = options.index + 1 if options

    @listenTo(@model, 'remove', @leave)
    @listenTo(@model, 'change', @render)

  events:
    'click span.delete': 'clear'
    'click label.name': 'edit'

  render: ->
    @$el.html(@template(item: @model, view: @))
    @

  clear: ->
    $.confirm
      text: '确认删除?',
      confirm: =>
        @package_setting.items.remove @model

  isShow: ->
    @action == 'show'

  edit: ->
    if @isShow()
      view = new Mis.Views.XiaoshouPackageItemsShow(model: @model)
    else
      view = new Mis.Views.XiaoshouPackageItemsForm(model: @model)
    @renderChild(view)
    $("#newPackageItem").html view.el
