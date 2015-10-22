class Mis.Views.ErrorView extends Backbone.View
  initialize: (options) ->
    @attrsWithErrors = options.attrsWithErrors

  render: ->
    @clearOldErrors()
    @renderErrors()

  clearOldErrors: =>
    @$("span.error_tip").remove()
    @$(".err").removeClass("err")

  renderErrors: =>
    _.each(@attrsWithErrors, @renderError)

  renderError: (errors, attr) =>
    errorString = if typeof errors == 'string' then errors else errors.join(", ")
    field = @fieldFor(attr)
    errorTag = $('<span>').addClass('error_tip').text(errorString)
    field.parent().append(errorTag)
    field.parent().addClass('err')

  fieldFor: (attr) =>
    @$("input[id*='_#{attr}']")
