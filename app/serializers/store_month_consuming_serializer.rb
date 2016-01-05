class StoreMonthConsumingSerializer < ActiveModel::Serializer
  attr_accessor :data

  def initialize(month = Time.now.month)
    @data = {}
    month = Time.now.month unless (1..12).include? month
    set_data(month)
  end

  private
  def set_data(month = Time.now.month)
    ((month - 6)..month).each do |i|
      next if i < 1
      @data[i.to_s + "月份"] = StoreMaterialSaleinfo.total_amount(i.month.ago)
    end
  end
end
