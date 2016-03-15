module Entities
  class MessageBalance < Grape::Entity
    expose(:total_quantity) {|model| model.total}
    expose :sent_quantity, :total_fee, :left_quantity
  end
end
