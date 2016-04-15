class StoreMaterialLog < ActiveRecord::Base
  include BaseModel

  belongs_to :logged_item, polymorphic: true

  before_validation :set_created_month

  scope :by_month, ->(month) { where(created_month: month) if month.present? }
  scope :by_material_id, ->(material_id) { where(store_material_id: material_id) if material_id.present? }
  scope :by_depot_id, ->(depot_id) { where(store_depot_id: depot_id) if depot_id.present? }

  def loggable!(loggable)
    self.logged_item = loggable
    self.save!
    self
  end

  def closings_amount
    closings['material_cost_price'].to_f * closings['material_quantity'].to_i
  end

  class << self
    def total_cost_prices
      all.inject(0.0) { |total, obj| total += obj.accruals['cost_price'].to_f }
    end

    def total_quantities
      all.inject(0) { |total, obj| total += obj.accruals['quantity'] }
    end

    def total_accruals_amount
      total_quantities * total_cost_prices || 0.0
    end
  end


  private
  def set_created_month
    self.created_month = Time.now.strftime('%Y%m')
  end
end
