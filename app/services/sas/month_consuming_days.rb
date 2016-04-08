module Sas
  class MonthConsumingDays < Base

    private
    def set_data(store)
      orderitems = store.store_order_items.by_month
      day = Time.now.beginning_of_month.to_date

      @data = {
        days: [],
        materials: [],
        services: [],
        packages: []
      }

      @data[:days] += (Time.now.beginning_of_month.day..Time.now.end_of_month.day).to_a

      @data[:days].each do |d|
        @data[:materials] << orderitems.by_day(day).materials.total_amount
        @data[:services] <<  orderitems.by_day(day).services.total_amount
        @data[:packages] <<  orderitems.by_day(day).packages.total_amount
        day += 1
      end

    end

  end
end
