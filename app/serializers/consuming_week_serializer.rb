class ConsumingWeekSerializer < ActiveModel::Serializer
  attr_accessor :data

  CONSUMING_LEVEL = {
    1..1000 => '0',
    1000..3000 => '1',
    3000..5000 => '2',
    5000..8000 => '3',
    8000..10000 => '4'
  }

  def initialize

    @data = [
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0],
    ]

    (0...Time.now.strftime("%w").to_i).each do |i|
      day = i.day.ago
      index = day.strftime("%w").to_i - 1
      StoreCustomer.all.each do |customer|
        amount = customer.orders.by_day(day).total_amount
        CONSUMING_LEVEL.select do |level, flag|
          if level === amount
            @data[flag.to_i][index] += 1
            break
          end
        end
      end
    end
  end

end
