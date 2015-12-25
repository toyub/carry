class Mis.Models.StoreCustomerSettlement extends Backbone.Model

  urlRoot: '/api/store_customer_settlement'

  modelName: 'store_customer_settlement'

  credit: -> Mis.Settings.Entity.credit[@get 'credit']

  noticePeriod: -> Mis.Settings.Entity.settlement[@get 'notice_period']

  paymentMode: -> Mis.Settings.Entity.payment[@get 'payment_mode']

  invoice: -> Mis.Settings.Entity.invoice[@get 'invoice_type']

