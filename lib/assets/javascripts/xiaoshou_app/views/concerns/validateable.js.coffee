Mis.Views.Concerns.Validateable =
  invalid: (model, errors) ->
    @handleError(model, errors)

  handleError: (model, responseOrErrors) ->
    errors = new Mis.Views.ErrorList(responseOrErrors)
    view = new Mis.Views.ErrorView(el: @el, errors: errors)
    view.render()

  validateBinding: () ->
    Backbone.Validation.bind(@)

    @listenTo(@model, 'validated:invalid', @invalid)
    @listenTo(@model, 'error', @handleError)
