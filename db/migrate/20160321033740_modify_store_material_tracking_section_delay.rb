class ModifyStoreMaterialTrackingSectionDelay < ActiveRecord::Migration
  def change
    if column_exists?(:store_material_tracking_sections, :delay)
      rename_column :store_material_tracking_sections, :delay, :delay_interval
    end
  end
end
