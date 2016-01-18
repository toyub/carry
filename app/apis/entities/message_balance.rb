module Entities
  class MessageBalance < Grape::Entity
    expose :balance_infos do
      expose :total_quantity do |balance, options|
        balance[:total_quantity]
      end
      expose :sent_quantity do |balance, options|
        balance[:sent_quantity]
      end
      expose :left_quantity do |balance, options|
        balance[:left_quantity]
      end
      expose :total_fee do |balance, options|
        balance[:total_fee]
      end
    end
  end
end
