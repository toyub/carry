class StoreMaterialOuting < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :requester, class_name: 'StoreStaff'

  has_many :items, class_name: 'StoreMaterialOutingItem'
  belongs_to :outingable, polymorphic: true

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
    self.numero = "OUT#{time_now.strftime('%Y%m%d')}#{today_count.to_s.rjust(7, '0')}"
  end
end
