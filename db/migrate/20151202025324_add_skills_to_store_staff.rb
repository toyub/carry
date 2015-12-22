class AddSkillsToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :skills, :json
  end
end
