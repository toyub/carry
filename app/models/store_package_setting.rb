class StorePackageSetting < ActiveRecord::Base
  include BaseModel

  belongs_to :store_package
  has_many :items, -> {where(deleted: false)}, class_name: 'StorePackageItem', dependent: :delete_all
  belongs_to :saleman_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'store_commission_template_id'
  before_save :set_retail_price

  accepts_nested_attributes_for :items, allow_destroy: true

  PERIOD_UNIT = {
    0 => '年',
    1 => '月',
    2 => '日'
  }

  def set_retail_price
    return if self.items.size == 0
    self.retail_price = self.items.map { |item| item.quantity * item.price }.sum
  end

  def valid_date
    "#{self.period}#{PERIOD_UNIT[self.period_unit]}"
  end

  def services
    self.items.packaged_services
  end

  def contains_service
    self.services.length > 0
  end

  def human_readable_period
    if self.period_enable
      "#{self.period}#{PERIOD_UNIT[self.period_unit]}"
    end
  end

  def sale_commission(staff, order_item, beneficiary)
    saleman_commission_template.present? ? saleman_commission_template.sale_commission(staff, order_item, beneficiary) : 0.0
  end

end
