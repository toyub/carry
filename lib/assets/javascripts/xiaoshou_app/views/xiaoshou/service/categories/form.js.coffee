class Mis.Views.XiaoshouServiceCategoriesForm extends Backbone.View
  el: '#FloatWindow'

  events:
    'submit #new_store_service_category': 'createOnSubmit'
    'click .close-window': 'hide'
    'click .cancel_btn': 'hide'

  template: JST['xiaoshou/service/categories/form']

  initialize: ->
    Backbone.Validation.bind(@)
    @model.on('error', @handleError, @)
    @model.on('sync', @handleSuccess, @)
    @model.on('validated:invalid', @invalid, @)

  render: ->
    @$el.html(@template(url: '/xiaoshou/service/categories'))
    @

  open: ->
    @render()
    @$el.fadeIn()
    @$(".FloatContent").slideDown()

  hide: ->
    @$el.fadeOut()
    @$(".FloatContent").slideUp()

  createOnSubmit: ->
    event.preventDefault()
    @model.set(@$('form').serializeJSON().store_service_category)
    console.log @model
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
