# == Schema Information
#
# Table name: store_material_order_items
#
#  id                      :integer          not null, primary key
#  store_id                :integer          not null
#  store_chain_id          :integer          not null
#  store_staff_id          :integer          not null
#  store_material_id       :integer          not null
#  store_supplier_id       :integer          not null
#  store_material_order_id :integer          not null
#  price                   :decimal(10, 2)   not null
#  quantity                :integer          not null
#  received_quantity       :integer          default(0), not null
#  returned_quantity       :integer          default(0), not null
#  process                 :integer          default(0), not null
#  amount                  :decimal(12, 4)
#  remark                  :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#

class StoreMaterialOrderItemSerializer < ActiveModel::Serializer
  attributes :id, :store_material_order_id, :quantity, :price, :amount, :store_material

  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root: nil)
  end
end
