class Mis.Views.KehuCustomerTagsShow extends Mis.Base.View
  tagName: 'label'

  className: 'js-tag'

  template: JST["kehu/tags/show"]

  render: ->
    @$el.html(@template(tag: @model))
    @
