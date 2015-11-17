class StoreSupplier < ActiveRecord::Base
  has_many :store_material_orders
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_material_root_category, class_name: 'StoreMaterialCategory'
  belongs_to :store_material_category

  INFO_SOURCES = {'1'=>'上门拜访','2' => '同行推荐','3'=>'网络搜索','4'=>'媒体杂志'}
  WEIGHTS = {'1' => '一般', '2'=>'重要', '3'=>'非常重要'}
  CLEARING_MODES = {'1'=>'现结', '2'=>'挂账'}
  CLEARING_CYCLES = {'1' => '按月', '2'=>'按周'}
  CLEARING_PAYMENT_METHODS={'1' => '现金', '2' => '银行卡', '3' => '支票', '4' => '支付宝'}

  def info_source
    INFO_SOURCES[self.info_source_id.to_s]
  end

  def weight
    WEIGHTS[self.weight_id.to_s]
  end

  def clearing_mode
    CLEARING_MODES[self.clearing_mode_id.to_s]
  end

  def clearing_cycle
    CLEARING_CYCLES[self.clearing_cycle_id.to_s]
  end

  def clearing_payment_method
    CLEARING_PAYMENT_METHODS[self.clearing_payment_method_id.to_s]
  end

  def fill_percent
     ((self.attributes.values.count{|item| item.present?}/self.attributes.values.count.to_f)* 100).round(2)
  end

  def location_country
    Geo.countries.where(code: self.location_country_code).first
  end

  def location_state
    Geo.states(self.location_country_code).where(code: self.location_state_code).first
  end

  def location_city
    Geo.cities(self.location_country_code, self.location_state_code).where(code: self.location_city_code).first
  end

  def status_suspended?
    self.status == 1
  end
end

# == Schema Information
#
# Table name: store_suppliers
#
#  id                              :integer          not null, primary key
#  store_id                        :integer          not null
#  store_chain_id                  :integer          not null
#  store_staff_id                  :integer          not null
#  store_material_root_category_id :integer
#  store_material_category_id      :integer
#  numero                          :string(45)
#  name                            :string(45)       not null
#  mnemonic                        :string(45)
#  contact_name                    :string(45)
#  contact_phone_number            :string(45)
#  contact_tel_number              :string(45)
#  contact_fax_number              :string(45)
#  contact_email                   :string(45)
#  location_country_code           :string(45)
#  location_state_code             :string(45)
#  location_city_code              :string(45)
#  location_address                :string(45)
#  info_source_id                  :integer
#  weight_id                       :integer
#  clearing_mode_id                :integer
#  clearing_cycle_id               :integer
#  clearing_day                    :string(45)
#  clearing_bank                   :string(45)
#  clearing_account                :string(45)
#  clearing_vatin                  :string(45)
#  clearing_alarmify               :boolean          default(FALSE)
#  clearing_payment_method_id      :integer
#  remark                          :string(45)
#  status                          :integer          default(0)
#  created_at                      :datetime
#  updated_at                      :datetime
#
