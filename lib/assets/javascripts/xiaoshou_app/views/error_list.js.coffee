class Mis.Views.ErrorList
  constructor: (responseOrErrors) ->
    if responseOrErrors && responseOrErrors.responseText
      @attributesWithErrors = JSON.parse(responseOrErrors.responseText).errors
    else
      @attributesWithErrors = responseOrErrors

_.extend(Mis.Views.ErrorList.prototype,
  each: (iterator) ->
    _.each @attributesWithErrors, iterator
  size: () ->
    _.size @attributesWithErrors
)
