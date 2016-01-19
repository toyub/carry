module Entities
  class MessageBalance < Grape::Entity
    expose :balance_infos do |balance, options|
      {
        total_quantity: balance[:total_quantity],
        sent_quantity: balance[:sent_quantity],
        left_quantity: balance[:left_quantity],
        total_fee: balance[:total_fee]
      }
    end
  end
end
