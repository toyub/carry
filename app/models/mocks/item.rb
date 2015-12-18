module Mocks
  class Item
    def self.mock
      
      {
        name: '3M Beat Oil',
        speci: '1500ml',
        unit: 'Bottle',
        quantity: 1,
        price: 350,
        huiyuan_price: ['320','-'].sample,
        cut: 2,
        amount: 298,
        denomination: 223
      }
    end
  end
end