class StoreMaterialTransReceipt < StoreMaterialReceipt
  has_many :items, class_name: 'StoreMaterialTransReceiptItem', foreign_key: 'store_material_receipt_id'
end
