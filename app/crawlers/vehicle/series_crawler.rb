module Crawlers
  module Vehicle
    class SeriesParser
      def initialize(vehicle_manufacturer, series_json)
        @vehicle_manufacturer = vehicle_manufacturer
        @serieses = series_json
      end

      def parse!
        @serieses.each do |series|
          vehicle_series = VehicleSeries.find_or_initialize_by(name: series['name'], vehicle_manufacturer_id: @vehicle_manufacturer.id)
          vehicle_series.vehicle_brand_id =  @vehicle_manufacturer.vehicle_brand_id
          vehicle_series.save!
          Jobs::VehicleModelCrawlerJob.perform_later(RemoteUrls.year_and_model_uri(series['id']), vehicle_series)
        end
      end

      def process_page_results(page)
        
      end
    end
  end
end
