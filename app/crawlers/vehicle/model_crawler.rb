module Crawlers
  module Vehicle
    class ModelCrawler
      include ::Crawlable

      def initialize(website, vehicle_series)
        @website = website
        @vehicle_series = vehicle_series
      end

      def process_page_results(page)
        result_json = JSON.parse(page.body.encode(Encoding::UTF_8, Encoding::GB2312))
        create_vehicle_models(result_json['result']['yearitems'])
      end

      def create_vehicle_models(yearitems)
        yearitems.each do |yearitem|
          manufacturing_year = yearitem['name']
          yearitem['specitems'].each do |model|
            vehicle_model = VehicleModel.find_or_initialize_by(name: model['name'], vehicle_series_id: @vehicle_series.id)
            vehicle_model.manufacturing_year = manufacturing_year
            vehicle_model.min_price = model['minprice']
            vehicle_model.max_price = model['maxprice']
            vehicle_model.save!
          end
        end

        @vehicle_series.min = @vehicle_series.vehicle_models.minimum(:min_price)
        @vehicle_series.max = @vehicle_series.vehicle_models.maximum(:max_price)
        @vehicle_series.save!
      end

      def self.crawl(website, vehicle_series)
        ::CrawlerRunner.new(self.new(website, vehicle_series), ::MechanizeAgent.new ).crawl if website.present?
      end
    end
  end
end
