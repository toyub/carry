class Mis.Views.XiaoshouSharedSearchForm extends Support.CompositeView

  template: JST['xiaoshou/shared/search_form']

  events:
    'submit #search': 'searchOnSubmit'
    'click #priceSortList li': 'sortByPrice'

  render: ->
    @$el.html(@template())
    @

  searchOnSubmit: (event) ->
    event.preventDefault()

    @collection.fetch(data: $("form").serializeJSON())

  sortByPrice: (e) ->
    direction = $(e.target).data('direction')
    @$("#priceSortList input").val(direction)
    options = @$el.find(':input').filter(() -> $.trim(this.value).length > 0).serializeJSON()
    @collection.fetch(data: options)
