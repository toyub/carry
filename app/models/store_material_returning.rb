class StoreMaterialReturning < ActiveRecord::Base
  belongs_to :sotre
  belongs_to :store_chain
  belongs_to :store_staff
  belongs_to :store_supplier
  has_many :items, class_name: 'StoreMaterialReturningItem'

  accepts_nested_attributes_for :items

  before_save :save_search_keys
  before_create :set_numero

  private
  def save_search_keys
    self.search_keys = self.items.map(&->(item){item.store_material.name}).join(',').truncate(255)
  end

  def set_numero
    time_now = Time.now
    today_count = self.class.unscoped.where('created_at between ? and ?', time_now.beginning_of_day, time_now.end_of_day).count(:id) + 1
    self.numero = "R#{time_now.strftime('%Y%m%d')}#{today_count.to_s.rjust(7, '0')}"
  end
end
