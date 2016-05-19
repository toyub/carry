class Mis.Views.XiaoshouSharedTop extends Mis.Base.View
  className: 'main_top'

  template: JST['xiaoshou/shared/top']

  PAGES:
    'package': 'XiaoshouPackagesIndex'
    'service': 'XiaoshouServiceProfilesIndex'

  events: ->
    'click a.back_to_list' : 'backTOList'

  initialize: (options = {}) ->
    @options = options

  backTOList: (e)->
    e.preventDefault()
    window.location.replace("/xiaoshou/main#store_customers")

  render: ->
    @$el.html(@template(@options))
    @
