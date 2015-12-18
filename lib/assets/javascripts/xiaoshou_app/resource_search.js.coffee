class Mis.ResourceSearch
  constructor: (collection) ->
    @collection = collection
    @filteredCollection = new collection.constructor(collection.models)

  search: (query) ->
    @filteredCollection.fetch(query)
