class StorePackage < ActiveRecord::Base
  include BaseModel
  include RandomTextable

  random :code

  has_many :uploads, class_name: 'StoreFile', as: :fileable, dependent: :destroy
  has_one :package_setting, class_name: 'StorePackageSetting', dependent: :destroy
  has_many :trackings, class_name: 'StorePackageTracking', dependent: :destroy
  has_many :store_subscribe_order_items, as: :itemable
  has_many :store_order_items, as: :itemable

  after_create :create_one_setting

  alias_attribute :retail_price, :price

  scope :by_month, ->(month = Time.now) {where("created_at between ? and ?", month.at_beginning_of_month, month.at_end_of_month)} 

  def create_one_setting
    self.create_package_setting(creator: self.creator)
  end

  def contain_service?
    self.package_setting.items.where(package_itemable_type: "StoreService").count > 0
  end

  def point
    self.package_setting.point
  end

  def vip_price
    0
  end

  def category
  end

  def self.top_sales_by_month(sort_by = 'amount', month = Time.now)
    id = StoreOrderItem.packages.by_month(month).group(:orderable_id).order("sum_#{sort_by}").limit(1).sum(sort_by).keys[0]
    find_by_id(id)
  end

  def self.amount_by_month(month = Time.now)
    StoreOrderItem.packages.by_month.sum(:amount)
  end

end
