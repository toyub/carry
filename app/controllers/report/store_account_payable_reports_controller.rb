module Report
  class StoreAccountPayableReportsController < BaseController
    def index
      @payable_reports = current_store.store_account_reports.payables#.by_created_month
    end
  end
end
