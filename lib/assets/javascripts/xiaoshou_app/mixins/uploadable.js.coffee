Mis.Mixins.Uploadable =

  renderUploadTemplate: ->
    upload = new Mis.Views.XiaoshouUploadsTemplate(collection: @model.uploads, action: @action)
    @renderChild(upload)
    @$("#uploadTemplate").html upload.el

  included: ->
    @::action = s.underscored(@::constructor.name).split("_").pop()

  uploadImages: ->
    url = @model.url() + '/save_picture'
    route_to = window.location.pathname + '#' + @model.url()
    uploading($('#preview_list > img'), url, route_to) if $('#preview_list > img').length > 0
