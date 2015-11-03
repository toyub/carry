class StoreRenewalRecords < ActiveRecord::Migration
  def change
    create_table 'store_renewal_records' do |t|
      t.integer   :store_id
      t.integer   :staffer_id
      t.integer   :renewal_type_id
      t.datetime  :paid_at
      t.decimal   :amount
      t.integer   :payment_type_id
      t.integer   :invoice_type_id
      t.boolean   :receipt_required
      t.string    :remark

      t.datetime  :created_at
      t.datetime  :updated_at
    end
  end
end
