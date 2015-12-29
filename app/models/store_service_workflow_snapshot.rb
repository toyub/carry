class StoreServiceWorkflowSnapshot < ActiveRecord::Base
  include BaseModel

  belongs_to :store_order_item
  belongs_to :store_service, class_name: "StoreServiceSnapshot", foreign_key: :store_service_id
  belongs_to :sales_commission, class_name: 'StoreCommissionTemplate', foreign_key: :sales_commission_template_id
  belongs_to :engineer_commission, class_name: 'StoreCommissionTemplate', foreign_key: :engineer_commission_template_id
  belongs_to :store_service_workflow
  belongs_to :store_workstation

  validates :store_staff_id, presence: true
  validates :store_service_id, presence: true

  def engineer
    self.mechanic["name"]
  end

end
