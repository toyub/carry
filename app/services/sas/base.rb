module Sas
  class Base
    attr_reader :data

    def initialize(store)
      set_data(store)
    end

    def as_json(*args)
      @data
    end

    private
    def set_data
      # define at subclass
    end
  end
end
