class StoreMonthConsuming
  attr_reader :data

  def initialize(store, month)
    @data = {}
    set_data(store, month)
  end

  def self.to_json
    @data
  end

  private
  def set_data(store, month)
    ((month - 6)..month).each do |i|
      next if i < 1
      @data[i.to_s + "月份"] = store.store_material_saleinfos.amount_by_month(i.month.ago)
    end
  end
end
