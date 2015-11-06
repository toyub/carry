class CreateStoreEmployees < ActiveRecord::Migration
  def change
    create_table :store_employees do |t|
      t.integer   "employee_id"                                               null: false
      t.string    "last_name"
      t.string    "first_name"
      t.string    "employee_number_id"
      t.string    "department"
      t.string    "profession"
      t.string    "gender"                    limit: 6,  default: "male",     null: false
      t.datetime  "born"
      t.string    "education"
      t.string    "polity"
      t.string    "native_place"
      t.string    "census_register"
      t.string    "identity_card"
      t.string    "marital_status"
      t.string    "job"
      t.datetime  "employment_date"
      t.datetime  "termination"
      t.string    "reason_for_leave"
      t.string    "height"
      t.string    "weight"
      t.string    "phone_number"                                              null: false
      t.string    "mailbox"
      t.string    "address"
      t.string    "census_register_address"
      t.string    "contact_one"
      t.string    "contact_one_phone_number"
      t.string    "contact_two"
      t.string    "contact_two_phone_number"
      t.string    "remark"                     limit: 255
      t.datetime  "created_at"
      t.datetime  "updated_at"
    end
  end
end
