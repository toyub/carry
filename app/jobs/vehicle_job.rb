class VehicleJob < ActiveJob::Base
  queue_as :default

  def perform(letter)
    VehicleCrawler.crawl("http://www.autohome.com.cn/grade/carhtml/#{letter}.html")
  end
end
