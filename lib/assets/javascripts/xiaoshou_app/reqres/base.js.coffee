Mis.Reqres =
  getConsumableMaterialEntities: ->
    defer = $.Deferred()
    materials = new Mis.Collections.ConsumableStoreMaterials
    materials.fetch
      success: ->
        defer.resolve(materials)
    defer.promise()

  getRootMaterialCategoryEntities: ->
    defer = $.Deferred()
    categories = new Mis.Collections.StoreMaterialCategories
    categories.fetch
      success: ->
        defer.resolve categories
    defer.promise()
