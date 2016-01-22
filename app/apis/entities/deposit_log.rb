module Entities
  class DepositLog < Grape::Entity
    expose(:balance) { |log, options| log.balance }
    expose(:amount) { |log, options| log.amount }
    expose(:numero) { |log, options| log.store_order.try(:numero) }
    expose(:store_name) { |log, options| log.store.name }
    expose(:created_at) { |log, options| log.created_at.strftime('%Y-%m-%d') }
    expose(:amount_symbol) { |log, options| log.methematical_symbol }
  end
end
