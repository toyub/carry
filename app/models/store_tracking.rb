class StoreTracking < ActiveRecord::Base
  belongs_to :store_order
  belongs_to :trackable, polymorphic: true

  validates :title, presence: true
  validates :content, presence: true

  CONTACT_WAY = {
    0 => '电话',
    1 => '短信'
  }

  CATEGORY = {
    0 => '业务回访',
    1 => '投诉回访',
    2 => '业务提醒',
    3 => '售后回访',
    4 => '其他'
  }
  IDS_CONTACT_WAY=CONTACT_WAY.invert
  IDS_CATEGORY=CATEGORY.invert

  def category_name
    CATEGORY[self.category_id]
  end

  def contact_way
    CONTACT_WAY[self.contact_way_id]
  end

end
