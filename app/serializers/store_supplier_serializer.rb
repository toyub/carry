# == Schema Information
#
# Table name: store_suppliers
#
#  id                              :integer          not null, primary key
#  store_id                        :integer          not null
#  store_chain_id                  :integer          not null
#  store_staff_id                  :integer          not null
#  store_material_root_category_id :integer
#  store_material_category_id      :integer
#  numero                          :string(45)
#  name                            :string(45)       not null
#  mnemonic                        :string(45)
#  contact_name                    :string(45)
#  contact_phone_number            :string(45)
#  contact_tel_number              :string(45)
#  contact_fax_number              :string(45)
#  contact_email                   :string(45)
#  location_country_code           :string(45)
#  location_state_code             :string(45)
#  location_city_code              :string(45)
#  location_address                :string(45)
#  info_source_id                  :integer
#  weight_id                       :integer
#  clearing_mode_id                :integer
#  clearing_cycle_id               :integer
#  clearing_day                    :string(45)
#  clearing_bank                   :string(45)
#  clearing_account                :string(45)
#  clearing_vatin                  :string(45)
#  clearing_alarmify               :boolean          default(FALSE)
#  clearing_payment_method_id      :integer
#  remark                          :string(45)
#  status                          :integer          default(0)
#  created_at                      :datetime
#  updated_at                      :datetime
#

class StoreSupplierSerializer < ActiveModel::Serializer
  attributes :id, :name
end
