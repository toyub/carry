window.Mis =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Mixins: {}
  Base: {}
  Constants: {}
  initialize: ->
    console.log 'xxx'
    if not Backbone.History.started
      Backbone.history.start()

$(document).ready ->
  Mis.initialize()
