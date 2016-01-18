class CustomerConsumingDistribute
  attr_reader :data

  CONSUMING_LEVEL = {
    0..1000 => '0',
    1000..3000 => '1',
    3000..5000 => '2',
    5000..8000 => '3',
    8000..10000 => '4'
  }

  def initialize(store)
    set_data(store)
  end

  private
  def set_data(store)
    @data = [0, 0, 0, 0, 0]
    store.store_customers.all.each do |customer|
      CONSUMING_LEVEL.select do |level, flag|
        if level === customer.store_order_items.by_month.total_amount
          @data[flag.to_i] += 1
          break
        end
      end
    end
  end

end
