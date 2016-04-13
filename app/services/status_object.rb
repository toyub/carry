module StatusObject
  class Status
    attr_reader :notice, :customer, :success, :license_number, :store_vehicle_id, :vehicle

    def initialize(options = {})
      @success = options[:success]
      @notice = options[:notice]
      @customer = options[:customer]
      @vehicle = options[:vehicle]
      @license_number = options[:license_number]
      @store_vehicle_id = options[:store_vehicle_id]
    end

    def success?
      @success
    end
  end
end
