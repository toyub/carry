class StoreTracking < ActiveRecord::Base
  belongs_to :store_order

  CONTACT_WAY = {
    0 => '电话'
  }

  CATEGORY = {
    0 => '业务回访',
    1 => '投诉回访',
    2 => '业务提醒',
    3 => '其他'
  }

  def category_name
    CATEGORY[self.category_id]
  end

  def contact_way
    CONTACT_WAY[self.contact_way_id]
  end
end
