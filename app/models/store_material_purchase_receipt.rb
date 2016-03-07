class StoreMaterialPurchaseReceipt < StoreMaterialReceipt
  has_many :items, class_name: 'StoreMaterialInventoryRecord', foreign_key: 'store_material_receipt_id'

  def order
    self.items.first.store_material_order
  end
end
