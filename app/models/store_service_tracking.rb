class StoreServiceTracking < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service

end

# == Schema Information
#
# Table name: store_service_trackings
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  store_id         :integer          not null
#  store_chain_id   :integer          not null
#  store_staff_id   :integer          not null
#  store_service_id :integer
#  mode             :integer          default(1)
#  notice_required  :boolean          default(FALSE)
#  content          :string(255)
#  delay_interval   :integer          default(0)
#  delay_unit       :integer
#  trigger_timing   :integer
#
