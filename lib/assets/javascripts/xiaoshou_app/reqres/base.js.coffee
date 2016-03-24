Mis.Reqres =
  getConsumableMaterialEntities: ->
    defer = $.Deferred()
    materials = new Mis.Collections.ConsumableStoreMaterials
    materials.fetch
      success: ->
        defer.resolve(materials)
    defer.promise()
