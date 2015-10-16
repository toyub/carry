class Mis.Views.XiaoshouServiceProfilesItem extends Backbone.View

  tagName: 'tr'

  template: JST['xiaoshou/service/profiles/service']

  events:
    'click .name': 'showService'

  render: ->
    @$el.html(@template(@model.attributes))
    @

  showService: ->
    view = new Mis.Views.XiaoshouServiceProfilesShow(model: @model)
    $("#bodyContent").html(view.render().el)
