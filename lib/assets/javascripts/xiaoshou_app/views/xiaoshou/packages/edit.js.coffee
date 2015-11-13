class Mis.Views.XiaoshouPackagesEdit extends Backbone.View

  template: JST['xiaoshou/packages/edit']

  initialize: ->
    @model.on("sync", @handleSuccess, @)

  events:
    'submit #updatePackage': 'updateOnSubmit'
    'click li img': 'previewImage'
    'click #goToShow': 'goToShow'

  render: ->
    @$el.html(@template(package: @model))
    @renderNav()
    @renderForm()
    #@renderPackageItems()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouPackageNavsMaster(model: @model, active: 'package')
    @$("#masterNav").html view.render().el

  renderSubNav: ->
    view = new Mis.Views.XiaoshouPackageNavsSub()
    @$("#subNav").html view.render().el

  renderForm: ->
    view = new Mis.Views.XiaoshouPackagesForm(model: @model)
    @$("#packageForm").html view.render().el

  updateOnSubmit: ->
    event.preventDefault()
    @model.set $("#createPackage").serializeJSON()
    console.log @model
    @model.save() if @model.isValid(true)

  previewImage: (e) ->
    img = new Image()
    img.src = e.target.src
    $("#material_img_preview").html(img)

  goToShow: ->
    view = new Mis.Views.XiaoshouPackagesShow(model: @model)
    $("#bodyContent").html view.render().el

  handleSuccess: ->
    @goToShow()
