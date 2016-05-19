class AccountReportJob < ActiveJob::Base
  queue_as :default

  def perform
    Store.all.each do |store|
      report = CreateAccountReportService.new(store)
      report.call
    end
  end

end
