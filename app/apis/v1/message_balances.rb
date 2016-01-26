module V1
  class MessageBalances < Grape::API

    resource :message_balances do
      before do
        authenticate_user!
      end

      add_desc '短信条数相关信息列表'
      params do
        optional :store_id, type: Integer, desc: "所属门店ID"
      end
      get do
        store = Store.find_by(params[:store_id]) || {}
        present store, with: ::Entities::MessageBalanceInfo
      end
    end

  end
end
