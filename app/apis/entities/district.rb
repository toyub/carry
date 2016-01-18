module Entities
  class District < Grape::Entity
    expose :code do |district, options|
      district.first
    end

    expose :name do |district, options|
      district.last
    end

    expose :cities do |district, options|
      Geo.cities('1', district.first).map do |city|
        {code: city.code, name: city.name}
      end
    end

  end
end
