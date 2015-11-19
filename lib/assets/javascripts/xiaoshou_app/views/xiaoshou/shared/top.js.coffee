class Mis.Views.XiaoshouSharedTop extends Support.CompositeView

  template: JST['xiaoshou/shared/top']

  PAGES:
    'package': 'XiaoshouPackagesIndex'
    'service': 'XiaoshouServiceProfilesIndex'

  initialize: (options = {}) ->
    @options = options

  events:
    'click .back_to_list': 'backToList'

  render: ->
    @$el.html(@template(@options))
    @

  backToList: ->
    page = eval("Mis.Views.#{@constructor::PAGES[@options.redirect_url]}")
    view = new page(collection: @collection)
    $("#bodyContent").html view.render().el
