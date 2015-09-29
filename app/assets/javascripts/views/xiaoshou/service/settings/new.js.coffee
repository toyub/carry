class Mis.Views.XiaoshouServiceSettingsNew extends Backbone.View

  template: JST['xiaoshou/service/settings/new']

  initialize: ->
    @store = window.Store

  events:
    'click #createSetting': 'createOnClick'
    'click #getWorkstationCategory': 'getWorkstationCategory'
    'click #count_unlimited': 'disableEngineerCount'
    'click #count_limited': 'enableEngineerCount'
    'click #engineer_level_enable': 'toggleEngineerLevel'
    'click #standard_time_enable': 'toggleStandardTime'
    'click #buffering_time_enable': 'toggleBufferingTime'
    'click #unnominated_workstation': 'unnominatedWorkstation'
    'click #workflow_setting': 'enableWorkflowSetting'
    'click #create_workflow': 'openWorkflowForm'

  render: ->
    @$el.html(@template(store: @store, setting: @model))
    @

  unnominatedWorkstation: ->
    @$("#workstationCategories").hide()
    @$("#storeWorkstations").hide()
    @$("#getWorkstationCategory").text("")
    @model.workstations.reset()

  disableEngineerCount: ->
    @$("#engineer_count").attr('disabled', true)

  enableEngineerCount: ->
    @$("#engineer_count").attr('disabled', false)

  toggleEngineerLevel: ->
    if @$("#engineer_level_enable").attr('checked')
      @$("#engineer_level_enable").attr('checked', false)
      @$("#engineer_level").attr('disabled', true)
    else
      @$("#engineer_level_enable").attr('checked', 'checked')
      @$("#engineer_level").attr('disabled', false)

  toggleStandardTime: ->
    if @$("#standard_time_enable").attr("checked")
      @$("#standard_time_enable").attr('checked', false)
      @$("#standard_time").attr('disabled', true)
      @$("#factor_time").attr('disabled', true)
    else
      @$("#standard_time_enable").attr('checked', 'checked')
      @$("#standard_time").attr('disabled', false)
      @$("#factor_time").attr('disabled', false)

  toggleBufferingTime: ->
    if @$("#buffering_time_enable").attr("checked")
      @$("#buffering_time_enable").attr("checked", false)
      @$("#buffering_time").attr("disabled", true)
    else
      @$("#buffering_time_enable").attr("checked", 'checked')
      @$("#buffering_time").attr("disabled", false)

  createOnClick: (e) ->
    e.preventDefault()
    @model.set @$(".j_regular_setting").find("input,select").serializeJSON()
    console.log @model
    console.log @model.toJSON()
    #@model.save

  getWorkstationCategory: ->
    if @$("input[name=nominated_workstations]:checked").val() == 'true'
      @$("#workstationCategories").empty()
      @store.workstationCategories.each @addWorkstationCategory
      @$("#workstationCategories").show()

  addWorkstationCategory: (category) =>
    view = new Mis.Views.XiaoshouServiceWorkstationsCategory(model: category, setting: @model)
    @$("#workstationCategories").append view.render().el

  enableWorkflowSetting: ->
    @$("#create_workflow").attr('disabled', false)

  openWorkflowForm: ->
    model = new Mis.Models.StoreServiceWorkflow()
    view = new Mis.Views.XiaoshouServiceWorkflowsForm(model: model)
    view.open()

