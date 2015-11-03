class StoreMaterialSaleinfoService < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_saleinfo
  belongs_to :mechanic_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'mechanic_commission_template_id'

  MECHANIC_LEVELS = {
    0 => "初级以上(含初级)",
    1 => "中级以上(含中级)",
    2 => "高级以上(含高级)",
    3 => "专家"
  }
end
<<<<<<< HEAD

# == Schema Information
#
# Table name: store_material_saleinfo_services
#
#  id                           :integer          not null, primary key
#  store_id                     :integer          not null
#  store_chain_id               :integer          not null
#  store_staff_id               :integer          not null
#  store_material_id            :integer
#  store_material_saleinfo_id   :integer
#  store_commission_template_id :integer
#  name                         :string(45)       not null
#  mechanic_level               :integer          default(1), not null
#  work_time                    :integer
#  work_time_unit               :string(45)
#  work_time_in_seconds         :integer
#  tracking_needed              :boolean          default(FALSE)
#  tracking_delay               :integer
#  tracking_delay_unit          :string(10)
#  tracking_delay_in_seconds    :integer
#  tracking_contact_way         :integer
#  tracking_content             :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#
=======
>>>>>>> development
