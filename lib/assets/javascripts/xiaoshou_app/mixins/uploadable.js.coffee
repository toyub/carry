Mis.Mixins.Uploadable =

  renderUploadTemplate: ->
    upload = new Mis.Views.XiaoshouUploadsTemplate(collection: @model.uploads, action: @action)
    @renderChild(upload)
    @$("#uploadTemplate").html upload.el

  included: ->
    @::action = s.underscored(@::constructor.name).split("_").pop()

  uploadImages: ->
    url = @model.url() + '/save_picture'
    hash = '#' + @model.url().replace('/api', '')
    route_to = window.location.pathname + hash
    if $('#preview_list > img').length
      uploading($('#preview_list > img'), url, route_to)
    else
      window.location.hash = hash
