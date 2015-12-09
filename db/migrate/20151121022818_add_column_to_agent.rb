class AddColumnToAgent < ActiveRecord::Migration
  def change
    add_column :agents, :created_at, :datetime
     add_column :agents, :updated_at, :datetime
  end
end
