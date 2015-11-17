Mis.Mixins.Uploadable =

  renderUploadTemplate: ->
    view = new Mis.Views.XiaoshouUploadsTemplate(collection: @model.uploads, action: @action)
    @$("#uploadTemplate").html view.render().el

  included: ->
    @::action = s.underscored(@::constructor.name).split("_").pop()
