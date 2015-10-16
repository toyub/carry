class Mis.Views.XiaoshouServiceTrackingsNew extends Backbone.View

  template: JST['xiaoshou/service/trackings/new']

  render: ->
    @$el.html(@template())
    @renderNav()
    @renderSubNav()
    @renderProfileSummary()
    @renderReminds()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster()
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouServiceNavsSub()
    @$("#subNav").html view.render().el

  renderProfileSummary: ->
    view = new Mis.Views.XiaoshouServiceProfilesSummary(model: @model)
    @$("#profileSummary").html view.render().el

  renderReminds: ->
    @model.store_service.reminds.each @renderRemind

  renderRemind: (remind) =>
    view = new Mis.Views.XiaoshouServiceRemindsItem(model: remind)
    console.log view.render().el
    @$("#reminds").append view.render().el
