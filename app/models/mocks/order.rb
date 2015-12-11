module Mocks
  class Order
    def self.mock
      {
        numero: 'KLDSJFLSDJFLjSDKJLFJ',
        customer: Mocks::Customer.mock,
        items: 5.times.map{
          Mocks::Item.mock
        }
      }
    end
  end
end