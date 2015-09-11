class Mis.Views.XiaoshouServiceSettingsEdit extends Backbone.View
  initialize: ->
    @model.on('sync', @handleSuccess, @)

  el: 'body'

  events:
    'submit #update_store_service': 'updateOnSubmit'
    'click #regular_setting': 'enableRegularSetting'
    'click #workflow_setting': 'enableWorkflowSetting'
    'click #create_workflow': 'newWorkFlow'
    'click #count_unlimited': 'disableEngineerCount'
    'click #count_nominated': 'enableEngineerCount'
    'click #engineer_level_enable': 'toggleEngineerLevel'
    'click #buffering_time_enable': 'toggleBufferingTime'
    'click #standard_time_enable': 'toggleStandardTime'
    'click #unnominated_workstation': 'disableNominatedWorkstation'
    'click #nominated_workstation': 'enableNominatedWorkstation'
    'click span#get_workstation_category': 'toggleWorkstationCategory'
    'click #workstation_categories li': 'selectCategory'
    'click #delay_allowed': 'toggleDelayAllowed'
    'click #unlimited_mechanics': 'toggleEngineerCount'
    'click #nominate_station_in_process': 'enableNomiatedWorkstationProcess'
    'click #random_station_in_process': 'disableNomiatedWorkstationProcess'

  updateOnSubmit: ->
    event.preventDefault()
    #@model.clear(silent: true)
    if @isGeneral()
      attrs = @$('#update_store_service').find(':input').filter(() -> $.trim(this.value).length > 0).serializeJSON().store_service
      store_service_workflows_attributes = []
      store_service_workflows_attributes.push(attrs['store_service_workflows_attributes'][0])
      attrs['store_service_workflows_attributes'] = store_service_workflows_attributes
      @model.set(attrs)
      console.log @model
      #@model.save() if @model.isValid(true)

  isGeneral: =>
    @$("#regular_setting").attr('checked')

  handleSuccess: ->
    console.log 'success'

  enableRegularSetting: ->
    $("#regular_setting").attr('checked', true)
    $("#workflow_setting").attr('checked', false)
    $("div.j_regular_setting table input").attr('disabled', false)
    $("div.j_regular_setting table select").attr('disabled', false)
    $("div.j_workflow_setting h2 input.do_open_list_new_page").removeClass('btn').addClass('not_available').attr('disabled', true).show()
    $("div.j_workflow_setting div.do_list_new_page input").attr('disabled', true)
    $("div.j_workflow_setting div.do_list_new_page").hide()

  enableWorkflowSetting: ->
    $("#workflow_setting").attr('checked', true)
    $("#regular_setting").attr('checked', false)
    $("div.j_regular_setting table input").attr('disabled', true)
    $("div.j_regular_setting table select").attr('disabled', true)
    $("div.j_workflow_setting h2 input.do_open_list_new_page").removeClass('not_available').addClass('btn').attr('disabled', false)
    $("div.j_workflow_setting div.do_list_new_page input").attr('disabled', false)

  newWorkFlow: ->
    collection = new Mis.Collections.StoreServiceWorkflows()
    view = new Mis.Views.XiaoshouServiceSettingsWorkflowForm(collection: collection, store_service: @model, model: new Mis.Models.StoreServiceWorkflow())
    view.show()
    $('#create_workflow').hide()

  disableEngineerCount: ->
    $("#engineer_count").attr('disabled', true)

  enableEngineerCount: ->
    $("#engineer_count").attr('disabled', false)

  toggleEngineerLevel: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false).val(false)
      $("#engineer_level").attr('disabled', true)
    else
      $(event.currentTarget).attr('checked', 'checked').val(true)
      $("#engineer_level").attr('disabled', false)

  toggleBufferingTime: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false).val(false)
      $("#buffering_time").attr('disabled', true)
    else
      $(event.currentTarget).attr('checked', 'checked').val(true)
      $("#buffering_time").attr('disabled', false)

  toggleStandardTime: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false).val(false)
      $(".j_standard_time").attr('disabled', true)
    else
      $(event.currentTarget).attr('checked', 'checked').val(true)
      $(".j_standard_time").attr('disabled', false)

  toggleWorkstationCategory: (event) ->
    if $("#nominated_workstation").attr('checked')
      if $(event.currentTarget).next().is(":visible")
        $(event.currentTarget).next().hide()
      else
        $(event.currentTarget).next().show()

  selectCategory: (event) ->
    $("span#get_workstation_category").text($(event.currentTarget).text())
    $("#workstation_categories").hide()
    $.get "/ajax/store_workstation_categories/#{$(event.currentTarget).attr('data-id')}/store_workstations"

  disableNominatedWorkstation: (event) ->
    $(event.currentTarget).attr('checked', 'checked')
    $("#nominated_workstation").attr('checked', false)
    $("span#get_workstation_category").text("")
    $("#workstation_categories").hide()
    $("div#j_workstations ul").hide()

  enableNominatedWorkstation: (event) ->
    $(event.currentTarget).attr('checked', 'checked')
    $("#unnominated_workstation").attr('checked', false)

  disableNomiatedWorkstationProcess: (event) ->
    $("#nominated_stations_in_process").hide()

  enableNomiatedWorkstationProcess: (event) ->
    $("#nominated_stations_in_process").show()

  toggleDelayAllowed: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false).val(false)
    else
      $(event.currentTarget).attr('checked', 'checked').val(true)

  toggleEngineerCount: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false)
      $("#engineer_count_enable").val('true')
      $("#limited_mechanics").attr('disabled', false)
    else
      $(event.currentTarget).attr('checked', 'checked')
      $("#engineer_count_enable").val('false')
      $("#limited_mechanics").attr('disabled', true)

