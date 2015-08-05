class StoreService < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service_category
  has_many :store_service_store_materials
  has_many :store_materials, through: :store_service_store_materials
  belongs_to :unit, foreign_key: 'store_service_unit_id'
  has_many :store_order_items, as: :orderable
  has_many :store_service_workflows

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :retail_price, presence: true
  validates :store_service_category_id, presence: true
  validates :store_staff_id, presence: true

  accepts_nested_attributes_for :store_service_store_materials, allow_destroy: true

end

# == Schema Information
#
# Table name: store_services
#
#  id                        :integer          not null, primary key
#  created_at                :datetime
#  updated_at                :datetime
#  store_staff_id            :integer          not null
#  store_chain_id            :integer          not null
#  store_id                  :integer          not null
#  name                      :string(45)
#  code                      :string(45)
#  standard_time             :integer
#  store_service_unit_id     :integer
#  retail_price              :decimal(10, 2)   default(0.0)
#  bargain_price             :decimal(10, 2)   default(0.0)
#  point                     :integer
#  introduction              :text(65535)
#  remark                    :text(65535)
#  store_service_category_id :integer
#  buffering_time            :integer
#  factor_time               :integer
#  engineer_count            :integer
#  engineer_level            :integer
#  position_mode             :integer
#  favorable                 :boolean          default(FALSE)
#
