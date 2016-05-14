module Report
  class StoreAccountReceivableReportsController < BaseController
    def index
      @receivable_reports = current_store.store_account_reports.incomes.by_created_month
    end
  end
end
