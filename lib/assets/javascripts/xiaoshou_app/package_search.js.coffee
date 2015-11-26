class Mis.PackageSearch
  constructor: (collection) ->
    @collection = collection
    @filteredCollection = new Mis.Collections.StorePackages(collection.models)

  search: (query) ->
    @filteredCollection.fetch(query)
