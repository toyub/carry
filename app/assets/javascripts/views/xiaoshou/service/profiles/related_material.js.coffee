class Mis.Views.XiaoshouServiceProfilesRelatedMaterial extends Backbone.View
  initialize: (options) ->
    @material = options.material

  template: JST['xiaoshou/service/profiles/related_material']

  className: 'list_content list_tr'

  render: ->
    @$el.html(@template(material: @material))
    @
