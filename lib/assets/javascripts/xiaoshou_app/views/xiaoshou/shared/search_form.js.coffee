class Mis.Views.XiaoshouSharedSearchForm extends Support.CompositeView

  template: JST['xiaoshou/shared/search_form']

  events:
    'submit #search': 'searchOnSubmit'
    'click #priceSortList li': 'sortByPrice'

  initialize: (search) ->
    @packageSearch = search

  render: ->
    @$el.html(@template())
    @

  searchOnSubmit: (event) ->
    event.preventDefault()

    @packageSearch.search(data: $("form").serializeJSON())

  sortByPrice: (e) ->
    direction = $(e.target).data('direction')
    @$("#priceSortList input").val(direction)
    options = @$el.find(':input').filter(() -> $.trim(this.value).length > 0).serializeJSON()
    @packageSearch.search(data: options)
