class StoreServiceSetting < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service
  has_many :workflows, class_name: 'StoreServiceWorkflow', dependent: :delete_all

  validates :store_staff_id, presence: true

  accepts_nested_attributes_for :workflows, allow_destroy: true
end

# == Schema Information
#
# Table name: store_service_settings
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  store_id         :integer          not null
#  store_chain_id   :integer          not null
#  store_staff_id   :integer          not null
#  setting_type     :integer          default(0)
#  store_service_id :integer
#
