module Mocks
  class Order
    @@sequence = 0
    def self.mock
      @@sequence = @@sequence + 1
      services = self.items
      materials = self.items
      packages = self.items
      
      order = {
        id: @@sequence,
        numero: "#{Time.now.strftime('%Y%m%d')}#{@@sequence.to_s.rjust(7, '0')}",
        status: rand(4),
        customer: Mocks::Customer.mock,
        amount: (rand * 100000).round(2),
        materials: services,
        services: materials,
        packages: packages
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
