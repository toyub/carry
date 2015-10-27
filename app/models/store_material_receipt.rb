class StoreMaterialReceipt < ActiveRecord::Base
  belongs_to :store_staff

  include BaseModel

  before_save :set_numero

  def set_numero
    self.numero = ApplicationController.helpers.make_numero('IN')
  end
end

# == Schema Information
#
# Table name: store_material_receipts
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  numero         :string(45)
#  remark         :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#
