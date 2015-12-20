module Mocks
  class Order
    @@sequence = 0
    def self.mock
      @@sequence = @@sequence + 1
      services = self.items
      materials = self.items
      packages = self.items
<<<<<<< e11068ae9bca0f5248477154fce4b807ce0ca861

      {
=======
      
      order = {
>>>>>>> 5c9e3319cb56026b609d1d6019babd1d4d88cc73
        id: @@sequence,
        numero: "#{Time.now.strftime('%Y%m%d')}#{@@sequence.to_s.rjust(7, '0')}",
        status: rand(4),
        customer: Mocks::Customer.mock,
        amount: (rand * 100000).round(2),
<<<<<<< e11068ae9bca0f5248477154fce4b807ce0ca861
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
=======
        materials: services,
        services: materials,
        packages: packages
>>>>>>> 5c9e3319cb56026b609d1d6019babd1d4d88cc73
      }

      $redis.set("order-#{order[:id]}", order.to_json)
      order
    end

    def self.items
      items = 8.times.map{Mocks::Item.mock}
      amount = items.map(&->(itemi){itemi[:amount]}).sum
      {
        items: items,
        amount: amount
      }
    end

    def self.find_by_id(id)
      $redis.get("order-#{id}")
    end
  end
end
