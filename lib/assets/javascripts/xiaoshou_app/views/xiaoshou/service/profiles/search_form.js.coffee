class Mis.Views.XiaoshouServiceProfilesSearchForm extends Mis.Base.View
  className: 'search_nav'

  template: JST['xiaoshou/service/profiles/search_form']

  events:
    'submit #search': 'searchOnSubmit'
    'click #priceSortList li': 'sortByPrice'
    'click div.prices li.submit': 'filterByPrice'
    'click li .filterByDate': 'filterByDate'
    'click li .favorable': 'filterByFavorable'

  initialize: (search) ->
    @serviceSearch = search

  render: ->
    @$el.html(@template())
    @

  searchOnSubmit: (event) ->
    event.preventDefault()

    @serviceSearch.search(reset: true, data: $("form").serializeJSON())

  sortByPrice: (e) ->
    direction = $(e.target).data('direction')
    @$("#priceSortList input").val(direction)
    @search()

  filterByPrice: ->
    @search()

  search: ->
    options = @$el.find(':input').filter(() -> $.trim(this.value).length > 0).serializeJSON()
    @serviceSearch.search(reset: true, data: options)

  filterByDate: (e) ->
    @$("input#filterFavorable").val("")
    $("input#filterDate").val($(e.target).data('date'))
    @search()

  filterByFavorable: (e) ->
    @$("input#filterDate").val("")
    $("input#filterFavorable").val($(e.target).data('favorable'))
    @search()
