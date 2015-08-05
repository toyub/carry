class StoreServiceStoreMaterial < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service
  belongs_to :store_material
  belongs_to :store_staff

  validates :store_staff_id, presence: true
  validates :store_material_id, presence: true
  validates :store_material_id, uniqueness: {scope: [:store_service_id, :store_id]}
  validates :use_mode, presence: true
  validates :unit, presence: true, if: Proc.new {|x| x.use_mode == USE_MODE[:scattered]}
  validates :dose, presence: true, if: Proc.new {|x| x.use_mode == USE_MODE[:scattered]}

  USE_MODE = {scattered: 1, entire: 0}
end

# == Schema Information
#
# Table name: store_service_store_materials
#
#  id                :integer          not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer
#  store_service_id  :integer          not null
#  store_material_id :integer          not null
#  use_mode          :integer          not null
#  unit              :string(45)
#  dose              :decimal(10, 2)
#
