class AddColumnOutingableItemToStoreMaterialOutingItem < ActiveRecord::Migration
  def change
    add_column :store_material_outing_items, :outingable_item_type, :string
    add_column :store_material_outing_items, :outingable_item_id, :integer
  end
end
