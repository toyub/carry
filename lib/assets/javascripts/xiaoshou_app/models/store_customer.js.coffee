class Mis.Models.StoreCustomer extends Backbone.Model

  urlRoot: '/api/store_customer'

  modelName: 'store_customer'

  defaults:
    tracking_accepted: true
    message_accepted: true
    gender: true

  initialize: ->
    @tags = new Mis.Collections.Tags(@get 'tags')
    @tempTags = new Mis.Collections.Tags(@get 'tags')

  male: -> String(@get 'gender') == 'true'

  married: -> String(@get 'married') == 'true'

  trackingAccepted: -> String(@get 'tracking_accepted') == 'true'

  messageAccepted: -> String(@get 'message_accepted') == 'true'

  education: -> Mis.Settings.Entity.education[@get 'education']

  age: -> @get('age')

  profession: -> Mis.Settings.Entity.profession[@get 'profession']

  income: -> Mis.Settings.Entity.income[@get 'income']

  assetsUrl: ->
    if @id
      "/crm/store_customers/#{@id}/store_assets"
    else
      "javascript:void(0)"

  repaymentsUrl: ->
    if @id
      "/crm/store_customers/#{@id}/store_repayments"
    else
      "javascript:void(0)"

  vehicleArchivesUrl: ->
    if @id
      if @get 'first_vehicle_id'
        "/crm/store_customers/#{@id}/store_vehicles/#{(@get 'first_vehicle_id')}"
      else
        "/crm/store_customers/#{@id}/store_vehicles/new"
    else
      "javascript:void(0)"

  ordersUrl: ->
    if @id
      "/crm/store_customers/#{@id}/expense_records"
    else
      "javascript:void(0)"

  trackingsUrl: ->
    if @id
      "/crm/store_customers/#{@id}/store_trackings"
    else
      "javascript:void(0)"

  preOrdersUrl: ->
    if @id
      "/crm/store_customers/#{@id}/pre_orders"
    else
      "javascript:void(0)"

  complaintsUrl: ->
    if @id
      "/crm/store_customers/#{@id}/complaints"
    else
      "javascript:void(0)"

  toJSON: ->
    json = _.clone(@attributes)
    json.taggings_attributes = @tags.map(
      (tag) ->
        {tag_id: tag.id}
    )
    json
