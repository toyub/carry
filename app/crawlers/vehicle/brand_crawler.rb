module Crawlers
  module Vehicle
    class BrandCrawler
      include ::Crawlable

      def process_page_results(page)
        result_json = JSON.parse(page.body.encode(Encoding::UTF_8, Encoding::GB2312))
        create_brands(result_json['result']['branditems'])
      end

      def create_brands(brands)
        brands.each do |brand|
          vehicle_brand = ::VehicleBrand.find_or_initialize_by(name: brand['name'])
          vehicle_brand.letter = brand['bfirstletter']
          vehicle_brand.save!
          ManufacturerCrawler.crawl(RemoteUrls.factory_and_series_uri(brand['id']), vehicle_brand)
        end
      end

      def self.crawl(website)
        ::CrawlerRunner.new( self.new(website), ::MechanizeAgent.new ).crawl if website.present?
      end
    end
  end
end
