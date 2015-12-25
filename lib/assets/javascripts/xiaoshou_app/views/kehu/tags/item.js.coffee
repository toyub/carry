class Mis.Views.KehuCustomerTagsItem extends Mis.Base.View
  tagName: 'label'

  template: JST["kehu/tags/item"]

  events:
    'click .js-tag': 'selectedTag'


  render: ->
    @$el.html(@template(tag: @model, customer: @customer))
    @

  initialize: (options) ->
    @customer = options.customer

  selectedTag: (e) ->
    if $(e.target).prop("checked")
      @customer.tempTags.add @model
    else
      @customer.tempTags.remove @model
