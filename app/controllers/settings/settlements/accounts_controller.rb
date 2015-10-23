module Settings
  module Settlements
    class AccountsController < Settings::BaseController
      def index
        @store = current_store
      end

      def create
        account = StoreSettlementAccount.new(account_params)
        account.store_staff_id = current_user.id
        account.save
        render json: account
      end

      def update
        store = current_store
        account = store.store_settlement_accounts.find(params[:id])
        account.update(account_params)
        render json: account
      end

      def toggle_status
        store = current_store
        account = store.store_settlement_accounts.find(params[:id])
        if account.active?
          account.inactive!
        else
          account.active!
        end
        render json: account
      end

      private
      def account_params
        params.require(:account).permit(:name, :bank_name, :bank_card_number, :remark)
      end
    end
  end
end
