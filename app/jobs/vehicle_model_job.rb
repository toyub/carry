class VehicleModelJob < ActiveJob::Base
  queue_as :default

  def perform(url, vehicle_series)
    vehicle_series.vehicle_models << ModelCrawler.crawl(url)
  end
end
