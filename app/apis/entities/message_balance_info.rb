module Entities
  class SmsBalanceInfo < Grape::Entity
    expose(:total_quantity) {|model| model.total}
    expose :sent_quantity, :total_fee
    expose(:left_quantity) {|model| model.total - model.sent_quantity}

  end

  class MessageBalanceInfo < Grape::Entity
    expose :balance_infos, using: SmsBalanceInfo
    private
    def balance_infos
      object.sms_balance
    end
  end
end
