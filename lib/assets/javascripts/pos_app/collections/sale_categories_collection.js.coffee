class Mis.Models.SaleCategory extends Backbone.Model

class Mis.Collections.SaleCategoriesCollection extends Backbone.Collection
  model: Mis.Models.SaleCategory
  url: '/api/sale_categories'
