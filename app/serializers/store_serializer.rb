# == Schema Information
#
# Table name: stores
#
#  id              :integer          not null, primary key
#  store_chain_id  :integer          not null
#  admin_id        :integer
#  name            :string(60)       not null
#  business_status :integer          default(0)
#  payment_status  :integer          default(0)
#  created_at      :datetime
#  updated_at      :datetime
#

class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :engineer_levels

  has_many :service_categories
  has_many :root_material_categories
  has_many :store_materials
  has_many :store_workstation_categories
  has_many :workstations
  has_many :commission_templates

  ENGINEER_LEVEL = {
    '初级' => 1,
    '中级' => 2,
    '高级' => 3
  }

  def engineer_levels
    ENGINEER_LEVEL.invert
  end
end
