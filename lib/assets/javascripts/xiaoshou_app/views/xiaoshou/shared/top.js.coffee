class Mis.Views.XiaoshouSharedTop extends Mis.Base.View
  className: 'main_top'

  template: JST['xiaoshou/shared/top']

  PAGES:
    'package': 'XiaoshouPackagesIndex'
    'service': 'XiaoshouServiceProfilesIndex'

  initialize: (options = {}) ->
    @options = options

  render: ->
    @$el.html(@template(@options))
    @
