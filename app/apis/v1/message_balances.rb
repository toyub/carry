module V1
  class MessageBalances < Grape::API

    resource :message_balances do
      before do
        authenticate_user!
      end

      add_desc '短信条数相关信息列表'

      get do
        balances = SmsBalance.by_store
        balance_infos = {
          total_quantity: balances.sum(:total),
          sent_quantity: balances.sum(:sent_quantity),
          left_quantity: balances.map{ |balance| balance.remaining }.sum,
          total_fee: balances.sum(:total_fee)
        }
        present balance_infos, with: ::Entities::MessageBalanceInfo
      end
    end

  end
end
