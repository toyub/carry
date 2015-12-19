module Mocks
  class Material
    attr_accessor :id, :name, :speci, :unit, :price, :vip_price


    def as_json
      {
        name: 'Nimsd D I H',
        speci: 'NKIK HGH I3 98L',
        price: 234
      }
    end
  end
end