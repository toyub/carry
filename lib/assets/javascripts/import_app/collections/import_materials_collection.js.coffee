class Mis.Models.ImportMaterials extends Backbone.Model

  import: ->
    @trigger('importSave')

class Mis.Collections.ImportMaterialsCollection extends Backbone.Collection
  url: "/api/import/materials"
  model: Mis.Models.ImportMaterials

  checkExistByName: (name) ->
    isDupe = @any (_material) ->
      return _material.get('name') == name

    return false if (isDupe)

    true

  saveAll: (callback)->
    model.import() for model in @models
    callback()
