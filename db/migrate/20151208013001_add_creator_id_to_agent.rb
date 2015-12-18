class AddCreatorIdToAgent < ActiveRecord::Migration
  def change
    add_column :agents, :creator_id, :integer
  end
end
