class Mis.Models.ImportMaterials extends Backbone.Model

  import: ->
    @trigger('importSave')

class Mis.Collections.ImportMaterialsCollection extends Backbone.Collection
  url: "/api/import/materials"
  model: Mis.Models.ImportMaterials

  asSelectOptions: {
    root_categories: "",
    brands: "",
    units: "",
    manufacturers: ""
  }

  allModels: []

  checkExistByName: (name) ->
    isDupe = @any (_material) ->
      return _material.get('name') == name

    return true if (isDupe)

    false

  saveAll: ->
    for model, i in @models
      model.import()
      if i == (@models.length - 1)
        $.ajax({
          url: @url,
          method: 'post',
          data: {store_materials: @allModels},
          success: (res)->
            console.log res
            $("#loading-position").hide()
            window.location.replace("/kucun")
          error: (res)->
            console.log res
        })

