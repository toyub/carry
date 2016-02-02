Mis.Collections.StorePackages = Backbone.Collection.extend({
  model: Mis.Models.PackageItemable,
  url: "/api/pos/products/packages"
})
