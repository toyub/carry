class StoreServiceRemind < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service

  TIMING = { 1 => "开单后", 2 => "技师上岗后", 3 => "施工结束后" }

end

# == Schema Information
#
# Table name: store_service_reminds
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  store_id         :integer          not null
#  store_chain_id   :integer          not null
#  store_staff_id   :integer          not null
#  content          :string(255)
#  trigger_timing   :integer
#  mode             :integer
#  delay_interval   :integer
#  notice_required  :boolean
#  store_service_id :integer
#  enable           :boolean
#
