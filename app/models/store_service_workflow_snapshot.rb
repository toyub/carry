class StoreServiceWorkflowSnapshot < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service, class_name: "StoreServiceSnapshot", foreign_key: :store_service_id
  belongs_to :sales_commission, class_name: 'StoreCommissionTemplate', foreign_key: :sales_commission_template_id
  belongs_to :engineer_commission, class_name: 'StoreCommissionTemplate', foreign_key: :engineer_commission_template_id
  belongs_to :store_service_workflow
  belongs_to :store_workstation

  validates :store_staff_id, presence: true
  validates :store_service_id, presence: true

end

# == Schema Information
#
# Table name: store_service_workflow_snapshots
#
#  id                              :integer          not null, primary key
#  created_at                      :datetime
#  updated_at                      :datetime
#  store_id                        :integer          not null
#  store_chain_id                  :integer          not null
#  store_staff_id                  :integer          not null
#  engineer_level                  :integer
#  engineer_count                  :integer
#  position_mode                   :integer
#  standard_time                   :integer
#  buffering_time                  :integer
#  factor_time                     :integer
#  store_service_id                :integer          not null
#  sales_commission_subject        :integer
#  sales_commission_template_id    :integer
#  engineer_commission_subject     :integer
#  engineer_commission_template_id :integer
#  engineer_count_enable           :boolean
#  engineer_level_enable           :boolean
#  standard_time_enable            :boolean
#  buffering_time_enable           :boolean
#  store_workstation_ids           :string(255)
#  nominated_workstation           :boolean
#  name                            :string(45)
#  store_service_workflow_id       :integer
#  store_workstation_id            :integer
#  store_engineer_ids              :string(45)
#  store_service_setting_id        :integer
#
