class Mis.Views.XiaoshouServiceProfilesShow extends Backbone.View

  template: JST['xiaoshou/service/profiles/show']

  events:
    'click #preview_list img': 'previewImage'

  render: ->
    @$el.html(@template(service: @model))
    @

  previewImage: (event) ->
    src = $(event.target).attr('src')
    image = "<img src='#{src}' />"
    @$("#material_img_preview").html(image)
