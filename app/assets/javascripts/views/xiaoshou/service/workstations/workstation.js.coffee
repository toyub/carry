class Mis.Views.XiaoshouServiceWorkstationsWorkstation extends Backbone.View
  tagName: 'li'

  template: JST['xiaoshou/service/workstations/item']

  events:
    'click input.checked': 'toggleChecked'

  render: ->
    @$el.html(@template(@model.attributes))
    @

  toggleChecked: (event) ->
    if event.target.checked
      @model.workstations.add @model
    else
      @model.workstations.remove @model
