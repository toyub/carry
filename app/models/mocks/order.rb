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
        items: 5.times.map{
          Mocks::Item.mock
        }
      }
    end
  end
end