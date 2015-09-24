module Settings
  module Settlements
    class AccountsController < Settings::BaseController
      def index
        @store = current_store
      end
    end
  end
end
