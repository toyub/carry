class ChangeBonusDefaultFormatInStoreStaff < ActiveRecord::Migration
  def change
    change_column_default :store_staff, :bonus, {}
    change_column_default :store_staff, :skills, {}
    change_column_default :store_staff, :other, {}
  end
end
