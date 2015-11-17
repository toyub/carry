class Upload::StoreService < Upload::Base
  mount_base64_uploader :img, StoreServiceUploader
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
#  introduction              :text
#  remark                    :text
#  store_service_category_id :integer
#  buffering_time            :integer
#  factor_time               :integer
#  engineer_count            :integer
#  engineer_level            :integer
#  position_mode             :integer
#  favorable                 :boolean          default(FALSE)
#  setting_type              :integer          default(0)
#
# Indexes
#
#  store_services_store_service_category_id  (store_service_category_id)
#
