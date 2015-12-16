class RenamePaymentsPaymentMethod < ActiveRecord::Migration
  def change
    rename_column :payments, :payment_method, :payment_method_type
  end
end
