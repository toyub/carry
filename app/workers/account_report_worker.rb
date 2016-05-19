class AccountReportWorker
  include Sidekiq::Worker

  def perform
    AccountReportJob.perform_now
  end
end
