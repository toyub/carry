class AddCodeToInfoCategories < ActiveRecord::Migration
  def change
    add_column :info_categories, :code, :string
  end
end
