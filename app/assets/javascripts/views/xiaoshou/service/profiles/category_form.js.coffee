class Mis.Views.XiaoshouServiceProfilesCategoryForm extends Backbone.View
  id: 'FloatWindow'

  events:
    'submit #new_store_service_category': 'createOnSubmit'
    'click .close-window': 'hide'
    'click .cancel_btn': 'hide'

  template: JST['xiaoshou/service/profiles/category_form']

  initialize: ->
    Backbone.Validation.bind(@)
    @model.on('error', @handleError, @)
    @model.on('sync', @handleSuccess, @)
    @model.on('validated:invalid', @invalid, @)

  render: ->
    @$el.html(@template(url: '/xiaoshou/service/categories'))
    @

  show: ->
    @$el.fadeIn()
    @$(".FloatContent").slideDown()

  hide: ->
    @$el.fadeOut()
    @$(".FloatContent").slideUp()

  createOnSubmit: ->
    event.preventDefault()
    @model.set(@$('form').serializeJSON().store_service_category)
    @model.save() if @model.isValid(true)

  invalid: (model, errors) ->
    @handleError(model, errors)

  handleError: (model, responseOrErrors) ->
    if responseOrErrors && responseOrErrors.responseText
      new Mis.Views.ErrorView({el: @$("form"), attrsWithErrors: JSON.parse(responseOrErrors.responseText).errors}).render()
    else
      new Mis.Views.ErrorView({el: @$("form"), attrsWithErrors: responseOrErrors}).render()

  handleSuccess: ->
    @collection.add @model
    @hide()
