class StorePackage < ActiveRecord::Base
  include BaseModel
  include RandomTextable

  random :code

  has_many :uploads, class_name: 'StoreFile', as: :fileable, dependent: :destroy
  has_one :package_setting, class_name: 'StorePackageSetting', dependent: :destroy
  has_many :trackings, class_name: 'StorePackageTracking', dependent: :destroy
  has_many :store_subscribe_order_items, as: :itemable
  has_many :store_order_items, as: :orderable
  has_many :recommended_order_items, as: :itemable

  after_create :create_one_setting

  scope :by_month, ->(month = Time.now) {where("created_at between ? and ?", month.at_beginning_of_month, month.at_end_of_month)}
  scope :by_store, ->(store_id){ where(store_id: store_id) if store_id.present? }
  scope :by_store_chain, ->(chain_id){ where(store_chain_id: chain_id) if chain_id.present? }

  def create_one_setting
    self.create_package_setting(creator: self.creator)
  end

  def contain_service?
    self.package_setting.items.where(package_itemable_type: "StoreService").count > 0
  end

  def point
    self.package_setting.try(:point)
  end

  def valid_date
    self.package_setting.try(:valid_date)
  end

  def store_name
    store.name
  end

  def sold
    0
  end

  def vip_price
    0
  end

  def category
  end

  def saleman_commission_template
    package_setting.saleman_commission_template
  end

  def self.top_sales_by_month(sort_by = 'amount', month = Time.now)
    id = joins(:store_order_items)
      .where(store_order_items: {created_at: month.at_beginning_of_month..month.at_end_of_month})
      .group(:orderable_id).order("sum_#{sort_by} DESC").limit(1).sum(sort_by).keys[0]

    find_by_id(id)
  end

  def self.amount_by_month(month = Time.now)
    StoreOrderItem.packages.by_month.sum(:amount)
  end

  def commission(order_item, staff, beneficiary)
    package_setting.present? ? package_setting.sale_commission(order_item, staff, beneficiary) : 0.0
  end

  def sold_count
    store_order_items.count
  end

end
