module StatusObject
  class Status
    attr_reader :notice

    def initialize(options = {})
      @success = options[:success]
      @notice = options[:notice]
    end

    def success?
      @success
    end
  end
end
