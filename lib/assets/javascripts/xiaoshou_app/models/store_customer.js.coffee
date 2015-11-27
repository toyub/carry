class Mis.Models.StoreCustomer extends Backbone.Model

  urlRoot: '/api/store_customers'

  modelName: 'store_customer'

  defaults:
    gender: true

  EDUCATION:
    middle: '初中及以下'
    high: '高中(中专)'
    junior_college: '大专'
    graduate: '本科'
    postgraduate: '硕士及以上'

  PROFESSION:
    it: 'IT/互联网/通信/电子'
    energy: '能源/竣工'

  INCOME:
    low: '3000以下'
    middle: '3000 - 6000'
    high: '6000 - 10000'

  SETTLEMENT_MODE:
    cash: '现结'
    cash: ''

  income: ->
    @INCOME

  education: ->
    @EDUCATION

  profession: ->
    @PROFESSION

  male: ->
    String(@get 'gender') == 'true'

  married: ->
    String(@get 'married') == 'true'

  toJSON: ->
    hashWithRoot = {}
    json = _.clone(@attributes)
    json.district = {province: @get 'province', city: @get 'city', region: @get 'region'}
    hashWithRoot[@modelName] = json
    hashWithRoot
