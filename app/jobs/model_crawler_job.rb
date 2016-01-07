class ModelCrawlerJob < ActiveJob::Base
  queue_as :default

  def perform(url, vehicle_series)
    ModelCrawler.crawl(url).map do |model|
      name = model.search('p').first.text
      vehicle_model = vehicle_series.vehicle_models.find_or_create_by(name: name)
      vehicle_model.update(manufacturing_year: name.split('款').first)
    end
  end
end
