class Mis.Models.ImportMaterials extends Backbone.Model

class Mis.Collections.ImportMaterialsCollection extends Backbone.Collection
  url: "/api/import/materials"
  model: Mis.Models.ImportMaterials

  add: (material) ->
    isDupe = @any (_material) ->
      return _material.get('name') == material.name

    return false if (isDupe)

    Backbone.Collection.prototype.add.call(this, material);
    true
