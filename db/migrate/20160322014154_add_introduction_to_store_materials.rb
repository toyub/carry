class AddIntroductionToStoreMaterials < ActiveRecord::Migration
  def change
    add_column :store_materials, :introduction, :text
  end
end
