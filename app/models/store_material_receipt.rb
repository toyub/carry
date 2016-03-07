class StoreMaterialReceipt < ActiveRecord::Base
  belongs_to :store_staff

  belongs_to :source_order, polymorphic: true

  include BaseModel

  before_create :set_numero
  before_save :set_quantity
  before_save :set_amount
  before_save :save_search_keys

  def save_search_keys
    self.search_keys = self.items.map(&->(item){item.store_material.name}).join(',').truncate(255)
  end

  def set_quantity
    self.quantity = self.items.map(&->(item){item.quantity}).sum
  end

  def set_amount
    self.amount = self.items.map(&->(item){item.amount}).sum
  end

  def set_numero
    time_now = Time.now
    today_count = self.class.unscoped.where('created_at between ? and ?', time_now.beginning_of_day, time_now.end_of_day).count(:id) + 1
    self.numero = "IN#{time_now.strftime('%Y%m%d')}#{today_count.to_s.rjust(7, '0')}"
  end
end
