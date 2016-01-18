class StoreMonthConsuming
  attr_reader :data

  def initialize(store, month)
    @data = {
      months: [],
      figures: []
    }
    set_data(store, month)
  end

  private
  def set_data(store, month)
    ((month - 6)..month).each do |i|
      next if i < 1
      @data[:months] << i.to_s + "月份"
      @data[:figures] <<  store.store_material_saleinfos.amount_by_month(i.month.ago)
    end
  end
end
