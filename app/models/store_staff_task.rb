class StoreStaffTask < ActiveRecord::Base
  include BaseModel

  belongs_to :store_staff
  belongs_to :store_order_item
  belongs_to :taskable, polymorphic: true
  belongs_to :workflow_snapshot, class_name: StoreServiceWorkflowSnapshot.name, foreign_key: 'workflow_id'

  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month .. month.at_end_of_month) }

  def commission
    workflow_snapshot.mechanic_commission.present? ? workflow_snapshot.mechanic_commission.commission(store_order_item) : 0.0
  end
end
