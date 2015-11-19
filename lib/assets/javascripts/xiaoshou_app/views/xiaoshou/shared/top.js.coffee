class Mis.Views.XiaoshouSharedTop extends Support.CompositeView

  template: JST['xiaoshou/shared/top']

  PAGES:
    'package': 'XiaoshouPackagesIndex'
    'service': 'XiaoshouServiceProfilesIndex'

  initialize: (options = {}) ->
    @options = options

  render: ->
    @$el.html(@template(@options))
    @
