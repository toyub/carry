class Mis.Views.XiaoshouServiceSettingsEdit extends Mis.Base.View
  @include Mis.Views.Concerns.Top

  template: JST['xiaoshou/service/settings/edit']

  initialize: ->
    @store = Mis.store

    @listenTo(@model.workflows, 'add', @renderWorkflow)
    @listenTo(@model, 'sync', @handleSuccess)

  events:
    'click #updateSetting': 'updateOnClick'
    'click #getWorkstationCategory': 'getWorkstationCategory'
    'click #count_unlimited': 'disableEngineerCount'
    'click #count_limited': 'enableEngineerCount'
    'click #engineer_level_enable': 'toggleEngineerLevel'
    'click #standard_time_enable': 'toggleStandardTime'
    'click #buffering_time_enable': 'toggleBufferingTime'
    'click #unnominated_workstation': 'unnominatedWorkstation'
    'click #workflow_setting': 'enableWorkflowSetting'
    'click #create_workflow': 'openWorkflowForm'
    'click #closeWithoutSave': 'goToShow'

  render: ->
    @$el.html(@template(store: @store, setting: @model))
    @renderTop()
    @renderNav()
    @renderProfileSummary()
    @renderWorkflows() if !@model.isRegular()
    @

  renderNav: ->
    view = new Mis.Views.XiaoshouServiceNavsMaster(model: @model.store_service, active: 'setting')
    @renderChildInto(view, @$("#masterNav"))

  renderProfileSummary: ->
    view = new Mis.Views.XiaoshouServiceProfilesSummary(model: @model)
    @renderChildInto(view, @$("#profileSummary"))

  renderWorkflow: (workflow) =>
    view = new Mis.Views.XiaoshouServiceWorkflowsItem(model: workflow, setting: @model, action: 'edit')
    @appendChildTo(view, @$("#workflow_list"))
    @$("#workflow_list").parent().show()

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

  updateOnClick: (e) ->
    e.preventDefault()
    if $("input[name=setting_type]:checked").val() == String(Mis.Models.StoreServiceSetting.prototype.SETTING_TYPE.workflow)
      @model.set @$(".j_workflow_setting").find("input,select").serializeJSON()
    else
      @model.set @$(".j_regular_setting").find("input,select").serializeJSON()
    @model.save()

  getWorkstationCategory: ->
    if @$("input[name=nominated_workstations]:checked").val() == 'true'
      @$("#workstationCategories").empty()
      @store.workstationCategories.each @addWorkstationCategory
      @$("#workstationCategories").show()

  addWorkstationCategory: (category) =>
    view = new Mis.Views.XiaoshouServiceWorkstationsCategory(model: category, setting: @model)
    @appendChildTo(view, @$("#workstationCategories"))

  enableWorkflowSetting: ->
    @$("#create_workflow").attr('disabled', false)

  openWorkflowForm: ->
    model = new Mis.Models.StoreServiceWorkflow()
    view = new Mis.Views.XiaoshouServiceWorkflowsForm(model: model, setting: @model)
    @appendChildTo(view, @$(".j_workflow_setting"))

  handleSuccess: ->
    @goToShow()

  renderWorkflows: ->
    @model.workflows.each @renderWorkflow

  goToShow: ->
    @leave()
    view = new Mis.Views.XiaoshouServiceSettingsShow(model: @model)
    $("#bodyContent").html(view.render().el)
