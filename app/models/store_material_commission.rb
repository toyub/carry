class StoreMaterialCommission < ActiveRecord::Base
end

# == Schema Information
#
# Table name: store_material_commissions
#
#  id                           :integer          not null, primary key
#  type                         :string(45)
#  store_id                     :integer          not null
#  store_chain_id               :integer          not null
#  store_staff_id               :integer          not null
#  store_material_id            :integer
#  store_commission_template_id :integer
#  created_at                   :datetime
#  updated_at                   :datetime
#
# Indexes
#
#  type  (type)
#
