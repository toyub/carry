class Mis.Views.XiaoshouServiceSettingsWorkflowForm extends Backbone.View
  el: '#workflow_form'

  template: JST['xiaoshou/service/settings/workflow_form']

  initialize: (options) ->
    @store_service = options.store_service
    @workflow_view = options.view if @model.get('id')
    @model.urlRoot = @store_service.url() + '/store_service_workflows'
    @model.once('sync', @handleSuccess, @)
    @collection.once('add', @addOne, @)

  events:
    'click #cancel_workflow': 'hideWorkflowForm'
    'click #save_workflow': 'saveWorkflow'

  handleSuccess: ->
    if @workflow_view
      console.log('view')
      @workflow_view.render()
    else
      @collection.add @model
    @hideWorkflowForm()
    $('.do_new_lists').show()

  saveWorkflow: ->
    event.preventDefault()
    attrs = @$el.find(':input').filter(() -> $.trim(this.value).length > 0).serializeJSON().store_service_workflow
    console.log attrs
    @model.set(attrs)
    console.log @model
    @model.save() if @model.isValid(true)

  hideWorkflowForm: =>
    @$el.hide()
    @undelegateEvents()
    $('#create_workflow').show()

  render: ->
    @$el.html(@template(workflow: @model, levels: @store_service.get('engineer_levels'), workstations: @store_service.get('workstations'), commissions: @store_service.get('commissions')))
    @

  addOne: (workflow) ->
    view = new Mis.Views.XiaoshouServiceSettingsWorkflow(model: workflow, collection: @collection, store_service: @store_service)
    $('#workflow_list').append view.render().el

  show: ->
    @render()
    @$el.show()

