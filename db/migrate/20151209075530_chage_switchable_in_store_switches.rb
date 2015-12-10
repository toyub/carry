class ChageSwitchableInStoreSwitches < ActiveRecord::Migration
  def change
    change_table :store_switches do |t|
      t.change :switchable_type, :string
    end
  end
end
