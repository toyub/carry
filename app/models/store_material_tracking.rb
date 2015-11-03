class StoreMaterialTracking < ActiveRecord::Base
  belongs_to :store_material
  has_many :store_material_tracking_sections
end

# == Schema Information
#
# Table name: store_material_trackings
#
#  id                :integer          not null, primary key
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  store_material_id :integer          not null
#  enabled           :boolean          default(FALSE), not null
#  tracking_mode     :integer          default(0), not null
#  reminder_required :boolean          default(FALSE), not null
#  created_at        :datetime
#  updated_at        :datetime
#