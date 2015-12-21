class Mis.Views.KehuCustomerTagsForm extends Mis.Base.View
  template: JST["kehu/tags/form"]

  initialize: (options) ->
    @customer = options.customer
    @listenTo(window.Mis.store.tags, 'add', @render)

  events:
    'click a.close': 'close'
    'click .js-new-tag': 'createTag'
    'click .js-save': 'addTags'

  render: ->
    @$el.html(@template(customer: @customer))
    @renderTags()
    @

  renderTags: ->
    window.Mis.store.tags.each @renderTag

  renderTag: (tag) =>
    view = new Mis.Views.KehuCustomerTagsItem(model: tag, customer: @customer)
    console.log @$(".links")
    @prependChildTo(view, @$(".links"))

  close: (e) ->
    e.preventDefault()
    @leave()

  createTag: (e) ->
    e.preventDefault()
    model = new Mis.Models.Tag
      name: @$("input[name=name]").val()
    if model.isValid(true)
      model.save {},
        success: ->
          console.log model
          window.Mis.store.tags.add model

  addTags: (e) ->
    e.preventDefault()

    @customer.tags.reset(@customer.tempTags.models)
    @leave()
