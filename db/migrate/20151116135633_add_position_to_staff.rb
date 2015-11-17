class AddPositionToStaff < ActiveRecord::Migration
  def change
      add_column :store_staff, :store_position_id, :integer
  end
end
