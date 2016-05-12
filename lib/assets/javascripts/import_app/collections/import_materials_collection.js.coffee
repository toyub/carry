class Mis.Models.ImportMaterials extends Backbone.Model

class Mis.Collections.ImportMaterialsCollection extends Backbone.Collection
  url: "/api/import/materials"
  model: Mis.Models.ImportMaterials
