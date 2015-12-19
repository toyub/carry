module Mocks
  class Order
    @@sequence = 0
    def self.mock
      @@sequence = @@sequence + 1
      {
        id: @@sequence,
        numero: "#{Time.now.strftime('%Y%m%d')}#{@@sequence.to_s.rjust(7, '0')}",
        status: rand(4),
        customer: Mocks::Customer.mock,
        amount: (rand * 100000).round(2),
        materials: {
          count: 23,
          amount: 333.33,
          items: self.items
        },
        
        services: {
          count: 23,
          amount: 333.33,
          items: self.items
        },

        packages: {
          count: 33,
          amount: 333.33,
          items: self.items
        }
      }
    end

    def self.items
      rand(8).times.map{Mocks::Item.mock}
    end
  end
end