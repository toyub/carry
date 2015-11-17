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

class StoreServiceRemindSerializer < ActiveModel::Serializer
  attributes :id, :content, :mode, :delay_interval, :enable, :notice_required, :trigger_timing, :store_service_id

end
