class Mis.Views.XiaoshouPackageSalesSearchForm extends Mis.Base.View
  className: 'search_bar'

  template: JST['xiaoshou/package_sales/search_form']

  events: ->
    'click #search' : 'searchOnSubmit'

  initialize: (search) ->
    @orderItemSearch = search

  searchOnSubmit: (event) ->
    event.preventDefault()
    @orderItemSearch.search(reset: true, data: $("form").serializeJSON())
