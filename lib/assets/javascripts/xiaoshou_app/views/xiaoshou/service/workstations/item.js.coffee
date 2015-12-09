class Mis.Views.XiaoshouServiceWorkstationsItem extends Mis.Base.View
  tagName: 'li'

  template: JST['xiaoshou/service/workstations/item']

  initialize: (options) ->
    @setting = options.setting

  events:
    'click input.checked': 'toggleChecked'

  render: ->
    @$el.html(@template(@model.attributes))
    @

  toggleChecked: (event) ->
    if event.target.checked
      @setting.workstations.add @model
    else
      @setting.workstations.remove @model
