class Mis.Views.XiaoshouServiceProfilesMaterial extends Backbone.View
  initialize: (options) ->
    @material = options.material

  template: JST['xiaoshou/service/profiles/material']

  tagName: 'tr'

  events:
    'change td.Selection_calculation select.use_mode': 'showUnit'

  render: ->
    @$el.html(@template(material: @material))
    @

  showUnit: (event) ->
    if $(event.currentTarget).val() == '1'
      $(event.currentTarget).next().show()
    else
      $(event.currentTarget).next().hide()

