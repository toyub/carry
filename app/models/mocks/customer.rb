module Mocks
  class Customer
    def self.mock
      number = ('A'..'Z').to_a.sample + " #{(60466176 - (rand(19999999) + 9999999)).to_s(36).upcase}"
      {
            vehicle: {
              plate_number: number
            },
            screen_name: 'Linda White',
            phone_number: '16886865957',
            balance: '22',
            credit_limit: '0',
            points: '12'
       }
    end
  end
end