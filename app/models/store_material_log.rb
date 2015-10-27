class StoreMaterialLog < ActiveRecord::Base
  include BaseModel
end

# == Schema Information
#
# Table name: store_material_logs
#
#  id                :integer          not null, primary key
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  store_material_id :string(45)       not null
#  log_type          :string(45)
#  prior_value       :text
#  value             :text
#  created_at        :datetime
#  updated_at        :datetime
#
