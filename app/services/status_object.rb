module StatusObject
  class Status
    attr_reader :notice, :customer

    def initialize(options = {})
      @success = options[:success]
      @notice = options[:notice]
      @customer = options[:customer]
    end

    def success?
      @success
    end
  end
end
