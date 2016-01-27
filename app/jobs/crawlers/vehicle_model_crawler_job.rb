module Jobs
  class VehicleModelCrawlerJob < ActiveJob::Base
    def perform(website, vehicle_series)
      Crawlers::Vehicle::ModelCrawler.crawl(website, vehicle_series)
    end
  end
end