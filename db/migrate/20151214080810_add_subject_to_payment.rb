class AddSubjectToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :subject, :string
  end
end
