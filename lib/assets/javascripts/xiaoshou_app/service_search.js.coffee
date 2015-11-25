class Mis.ServiceSearch
  constructor: (collection) ->
    @collection = collection
    @filteredCollection = new Mis.Collections.StoreServices(collection.models)

  search: (query) ->
    @filteredCollection.fetch(query)
