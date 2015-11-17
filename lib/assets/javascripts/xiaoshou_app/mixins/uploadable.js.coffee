Mis.Mixins.Uploadable =

  renderUploadTemplate: ->
    view = new Mis.Views.XiaoshouUploadsTemplate(collection: @model.uploads, action: @action)
    @$("#uploadTemplate").html view.render().el

  included: ->
    @::action = s.underscored(@::constructor.name).split("_").pop()

  # TODO: 需要引入router来解决上传完跳转的问题
  uploadImages: ->
    url = @model.url() + '/save_picture'
    uploading($('#preview_list > img'), url) if $('#preview_list > img').length > 0
