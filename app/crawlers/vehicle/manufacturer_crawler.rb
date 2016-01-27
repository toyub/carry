module Crawlers
  module Vehicle
    class ManufacturerCrawler
      include ::Crawlable

      def initialize(website, vehicle_brand)
        @website = website
        @vehicle_brand = vehicle_brand
      end

      def process_page_results(page)
        result_json = JSON.parse(page.body.encode(Encoding::UTF_8, Encoding::GB2312))
        create_manufacturers_and_serieses(result_json['result']['factoryitems'])
      end

      def create_manufacturers_and_serieses(manufacturers)
        manufacturers.each do |manufacturer|
          vehicle_manufacturer = VehicleManufacturer.find_or_initialize_by(name: manufacturer['name'])
          vehicle_manufacturer.vehicle_brand_id = @vehicle_brand.id
          vehicle_manufacturer.save!
          SeriesParser.new(vehicle_manufacturer, manufacturer['seriesitems']).parse!
        end
      end

      def self.crawl(website, vehicle_brand)
        ::CrawlerRunner.new(self.new(website, vehicle_brand), ::MechanizeAgent.new ).crawl if website.present?
      end
    end
  end
end
