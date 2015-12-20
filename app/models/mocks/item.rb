module Mocks
  class Item
    def self.mock
      quantity = 2
      price = 330
      {
        name: '3M Gas Bam',
        speci: 'V3 56L 44I',
        retail_price: 370,
        vip_price: 350,
        discount: 20,
        discount_reason: 'YLD',
        price: price,
        quantity: quantity,
        amount: quantity * price
      }
    end
  end
end
