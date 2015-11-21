class Mis.Views.XiaoshouSharedSearchForm extends Mis.Base.View

  template: JST['xiaoshou/shared/search_form']

  events:
    'submit #search': 'searchOnSubmit'
    'click #priceSortList li': 'sortByPrice'
    'click div.prices li.submit': 'filterByPrice'
    'click li .filterByDate': 'filterByDate'

  initialize: (search) ->
    @packageSearch = search

  render: ->
    @$el.html(@template())
    @

  searchOnSubmit: (event) ->
    event.preventDefault()

    @packageSearch.search(reset: true, data: $("form").serializeJSON())

  sortByPrice: (e) ->
    direction = $(e.target).data('direction')
    @$("#priceSortList input").val(direction)
    @search()

  filterByPrice: ->
    @search()

  search: ->
    options = @$el.find(':input').filter(() -> $.trim(this.value).length > 0).serializeJSON()
    @packageSearch.search(reset: true, data: options)

  filterByDate: (e) ->
    $("input#filterDate").val($(e.target).data('date'))
    @search()
