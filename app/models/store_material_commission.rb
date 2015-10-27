class StoreMaterialCommission < ActiveRecord::Base
    belongs_to :store
    belongs_to :store_chain
    belongs_to :store_material
    belongs_to :creator, class_name: 'Staff', foreign_key: 'store_staff_id'

  def initialize(*args, &block)
    raise NotImplementedError, "#{self.class} is an abstract class and cannot be instantiated." if self.class == StoreMaterialCommission
    super
  end
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
