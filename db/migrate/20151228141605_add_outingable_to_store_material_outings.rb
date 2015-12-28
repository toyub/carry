class AddOutingableToStoreMaterialOutings < ActiveRecord::Migration
  def change
    add_column :store_material_outings, :outingable_type, :string
    add_column :store_material_outings, :outingable_id, :integer
  end
end
