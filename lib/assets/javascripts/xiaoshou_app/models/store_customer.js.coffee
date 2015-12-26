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

  toJSON: ->
    json = _.clone(@attributes)
    json.taggings_attributes = @tags.map(
      (tag) ->
        {tag_id: tag.id}
    )
    json
