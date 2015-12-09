class Mis.Views.ErrorView extends Backbone.View
  initialize: (options) ->
    @errors = options.errors

  render: ->
    $.alert(text: @errorMsg())

  errorMsg: ->
    res = []
    @errors.each((errors, attr) ->
      errorString = if typeof errors == 'string' then errors else errors.join(", ")
      res.push errorString
    )
    res.join(", ")

  clearOldErrors: =>
    @$("span.error_tip").remove()
    @$(".err").removeClass("err")

  renderErrors: =>
    @errors.each @renderError

  renderError: (errors, attr) =>
    errorString = if typeof errors == 'string' then errors else errors.join(", ")
    field = @fieldFor(attr)
    errorTag = $('<span>').addClass('error_tip').text(errorString)
    field.parent().append(errorTag)
    field.parent().addClass('err')

  fieldFor: (attr) =>
    @$("input[id*='_#{attr}']")
