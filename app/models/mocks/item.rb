module Mocks
  class Item
    def self.mock
      {
        name: '3M Gas Bam',
        speci: 'V3 56L 44I',
        retail_price: 370,
        vip_price: 350,
        discount: 20,
        discount_reason: 'YLD',
        price: 330,
        quantity: 1,
        amount: 330
      }
    end
  end
end
