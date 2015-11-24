class AddColumnToAgentPayment < ActiveRecord::Migration
  def change
    add_column :agent_payments, :created_at, :datetime
    add_column :agent_payments, :updated_at, :datetime
  end
end
