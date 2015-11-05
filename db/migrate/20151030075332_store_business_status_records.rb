class StoreBusinessStatusRecords < ActiveRecord::Migration
  def change
    create_table 'store_business_status_records' do |t|
      t.integer   :store_id
      t.integer   :staffer_id
      t.string    :reason
      t.integer   :previous_status
      t.integer   :status

      t.datetime  :created_at
      t.datetime  :updated_at
    end
  end
end
