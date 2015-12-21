class SetDefaultTrialPeriodInStoreStaff < ActiveRecord::Migration
  def change
    change_column_default :store_staff, :trial_period, 1
  end
end
