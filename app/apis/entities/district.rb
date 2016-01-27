module Entities
  class District < Grape::Entity
    expose(:code) { |district, options| district.first }
    expose(:name) { |district, options| district.last }
    expose :cities do |district, options|
      Geo.cities('1', district.first).map do |city|
        {
          code: city.code,
          name: city.name
        }
      end
    end

  end
end
