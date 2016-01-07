class StoreMonthConsumingDaysSerializer < ActiveModel::Serializer
  attr_accessor :data

  def initialize(orderitems)

    @data = {
      days: [],
      materials: [],
      services: [],
      packages: []
    }

    @data[:days] = (1..Date.today.day).to_a

    len = @data[:days].size - 1

    len.downto(0) do |i|
      date = i.days.ago
      @data[:materials] << orderitems.by_day(date).materials.total_amount
      @data[:services] <<  orderitems.by_day(date).services.total_amount
      @data[:packages] <<  orderitems.by_day(date).packages.total_amount
    end

  end

end
