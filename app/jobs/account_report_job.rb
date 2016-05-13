class AccountReportJob < ActiveJob::Base
  queue_as :default

  def perform(store)
    report = CreateAccountReportService.new(store)
    report.income
  end

end
