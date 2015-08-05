class Mis.Views.XiaoshouServiceSettingsEdit extends Backbone.View
  initialize: ->
    $('#new_store_service_workflow').validate(
      ignore: []
      submitHandler: (form) ->
        $(form).find('[type=submit]').attr('disabled', 'disabled')
        $(form).ajaxSubmit(
          dataType: 'json'
          success: (responseText, statusText, xhr) ->
            console.log 'sucesssfully created'
          error: (responseOrErrors, statusText, xhr) ->
            console.log 'need to fix errors showing'
            $(form).find('[type=submit]').attr('disabled', false)
        )
        false
    )

  el: 'body'

  events:
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
    'click #save_workflow': 'saveWorkflow'
    'click #delay_allowed': 'toggleDelayAllowed'
    'click #unlimited_mechanics': 'toggleEngineerCount'

  enableRegularSetting: ->
    $("div.j_regular_setting table input").attr('disabled', false)
    $("div.j_regular_setting table select").attr('disabled', false)
    $("div.j_workflow_setting h2 input.do_open_list_new_page").removeClass('btn').addClass('not_available').attr('disabled', true).show()
    $("div.j_workflow_setting div.do_list_new_page input").attr('disabled', true)
    $("div.j_workflow_setting div.do_list_new_page").hide()

  enableWorkflowSetting: ->
    $("div.j_regular_setting table input").attr('disabled', true)
    $("div.j_regular_setting table select").attr('disabled', true)
    $("div.j_workflow_setting h2 input.do_open_list_new_page").removeClass('not_available').addClass('btn').attr('disabled', false)
    $("div.j_workflow_setting div.do_list_new_page input").attr('disabled', false)

  newWorkFlow: ->
    $('div.do_list_new_page').show()
    $('#create_workflow').hide()

  disableEngineerCount: ->
    $("#store_service_workflow_engineer_count").attr('disabled', true)

  enableEngineerCount: ->
    $("#store_service_workflow_engineer_count").attr('disabled', false)

  toggleEngineerLevel: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false).val(false)
      $("#store_service_workflow_engineer_level").attr('disabled', true)
    else
      $(event.currentTarget).attr('checked', 'checked').val(true)
      $("#store_service_workflow_engineer_level").attr('disabled', false)

  toggleBufferingTime: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false).val(false)
      $("#store_service_workflow_buffering_time").attr('disabled', true)
    else
      $(event.currentTarget).attr('checked', 'checked').val(true)
      $("#store_service_workflow_buffering_time").attr('disabled', false)

  toggleStandardTime: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false).val(false)
      $("#store_service_workflow_standard_time").attr('disabled', true)
      $("#store_service_workflow_factor_time").attr('disabled', true)
    else
      $(event.currentTarget).attr('checked', 'checked').val(true)
      $("#store_service_workflow_standard_time").attr('disabled', false)
      $("#store_service_workflow_factor_time").attr('disabled', false)

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

  saveWorkflow: ->
    if $("input[name=process_name]").val().trim()
      console.log 'xxx'
    else
      ZhanchuangAlert("请至少填写流程名称")

  toggleDelayAllowed: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false).val(false)
    else
      $(event.currentTarget).attr('checked', 'checked').val(true)

  toggleEngineerCount: (event) ->
    if $(event.currentTarget).attr('checked')
      $(event.currentTarget).attr('checked', false).val(false)
      $("#limited_mechanics").attr('disabled', false)
    else
      $(event.currentTarget).attr('checked', 'checked').val(true)
      $("#limited_mechanics").attr('disabled', true)

