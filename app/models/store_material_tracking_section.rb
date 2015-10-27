class StoreMaterialTrackingSection < ActiveRecord::Base
  belongs_to :store_material_tracking
end

# == Schema Information
#
# Table name: store_material_tracking_sections
#
#  id                         :integer          not null, primary key
#  store_id                   :integer          not null
#  store_chain_id             :integer          not null
#  store_staff_id             :integer          not null
#  store_material_id          :integer          not null
#  store_material_tracking_id :integer          not null
#  timing                     :integer          default(1), not null
#  delay                      :integer          not null
#  delay_unit                 :string(10)       not null
#  delay_in_seconds           :integer          not null
#  contact_way                :integer          default(1), not null
#  content                    :string(255)      not null
#  created_at                 :datetime
#  updated_at                 :datetime
#
