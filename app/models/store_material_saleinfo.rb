class StoreMaterialSaleinfo  <  ActiveRecord::Base

  include BaseModel

  belongs_to :sale_category
  belongs_to :store_material
  belongs_to :store
  belongs_to :saleman_commission_template,
                          class_name: 'StoreCommissionTemplate', foreign_key: 'saleman_commission_template_id'

  has_many :services, class_name:'StoreMaterialSaleinfoService', dependent: :delete_all
  has_many :store_subscribe_order_items, as: :itemable
  has_many :store_order_items, as: :orderable
  has_many :recommended_order_items, as: :itemable

  scope :by_category, ->(sale_category_id){ where(sale_category_id: sale_category_id) if sale_category_id.present? }
  scope :exclude_service, -> { where(service_needed: false) }

  accepts_nested_attributes_for :services

  delegate :name, to: :store_material

  scope :by_month, ->(month = Time.now) {where("created_at between ? and ?", month.at_beginning_of_month, month.at_end_of_month)}


  def trackings
    trackings = store_material.try(:store_material_tracking).try(:sections)
  end

  def divide_unit_type
    MaterialDivideUnitType.find(self.divide_unit_type_id).try(:name)
  end

  def cost_price_per_unit
    if self.divide_total_volume.present?
      (self.store_material.cost_price.to_f / self.divide_total_volume.to_f).round(2)
    else
      self.store_material.cost_price.to_f
    end
  end

  def cost_price
    if self.divide_to_retail
      cost_price_per_unit
    else
      self.store_material.cost_price
    end
  end

  def point
    self.reward_points
  end

  def barcode
    store_material.try(:barcode)
  end

  def speci
    store_material.try(:speci)
  end

  def category
    sale_category
  end

  def commission( order_item, staff, beneficiary)
    saleman_commission_template.present? ? saleman_commission_template.sale_commission(order_item, staff, beneficiary) : 0.0
  end

  def self.top_sales_by_month(sort_by = 'amount', month = Time.now)
    id = joins(:store_order_items)
      .where(store_order_items: {created_at: month.at_beginning_of_month..month.at_end_of_month})
      .group(:orderable_id).order("sum_#{sort_by} DESC").limit(1).sum(sort_by).keys[0]

    find_by_id(id)
  end

  def self.amount_by_month(month = Time.now)
    joins(:store_order_items)
      .where(store_order_items: {created_at: month.at_beginning_of_month..month.at_end_of_month})
      .sum(:amount)
  end

  def to_snapshot!(order_item)
    self.services.each do |service|
      service.to_snapshot!(order_item)
    end
  end

  def inventory
    depot = self.store.store_depots.preferred.first
    self.store_material.inventory(depot.id)
  end

  def sold_count
    try(:store_order_items).try(:count)
  end
end
