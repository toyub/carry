module StatusObject
  class Status
    attr_reader :notice, :customer, :success, :license_number

    def initialize(options = {})
      @success = options[:success]
      @notice = options[:notice]
      @customer = options[:customer]
      @license_number = options[:license_number]
    end

    def success?
      @success
    end
  end
end
