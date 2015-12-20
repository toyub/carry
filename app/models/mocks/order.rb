module Mocks
  class Order
    @@sequence = 0
    def self.mock
      @@sequence = @@sequence + 1
      services = self.items
      materials = self.items
      packages = self.items

      {
        id: @@sequence,
        numero: "#{Time.now.strftime('%Y%m%d')}#{@@sequence.to_s.rjust(7, '0')}",
        status: rand(4),
        customer: Mocks::Customer.mock,
        amount: (rand * 100000).round(2),
        materials: {
          amount: materials.map(&->(itemi){itemi[:price]}).sum,
          items: materials
        },
        services: {
          amount: services.map(&->(itemi){itemi[:price]}).sum,
          items: services
        },
        packages: {
          amount: packages.map(&->(itemi){itemi[:price]}).sum,
          items: packages
        }
      }
    end

    def self.items
      rand(8).times.map{Mocks::Item.mock}
    end
  end
end
