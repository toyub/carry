class VehicleCrawlerScheduleJob < ActiveJob::Base
  queue_as :default

  def perform
    Crawlers::Vehicle::BrandCrawler.crawl(RemoteUrls.brand_uri)
  end
end
