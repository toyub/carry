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

    @data = {
      Mon: [0, 0, 0, 0, 0],
      Tue: [0, 0, 0, 0, 0],
      Wed: [0, 0, 0, 0, 0],
      Thu: [0, 0, 0, 0, 0],
      Fri: [0, 0, 0, 0, 0],
      Sat: [0, 0, 0, 0, 0],
      Sun: [0, 0, 0, 0, 0],
    }

    (0...Time.now.strftime("%w").to_i).each do |i|
      day = i.day.ago
      index = day.strftime("%a").to_sym
      StoreCustomer.all.each do |customer|
        amount = customer.store_order_items.by_day(day).total_amount
        CONSUMING_LEVEL.select do |level, flag|
          if level === amount
            @data[index][flag.to_i] += 1
            break
          end
        end
      end
    end
  end

end
