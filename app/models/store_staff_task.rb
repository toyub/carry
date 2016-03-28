class StoreStaffTask < ActiveRecord::Base
  include BaseModel

  belongs_to :store_order_item
  belongs_to :mechanic, class_name: 'StoreStaff', foreign_key: :mechanic_id
  belongs_to :taskable, polymorphic: true
  belongs_to :workflow_snapshot, class_name: StoreServiceWorkflowSnapshot.name, foreign_key: 'workflow_id'

  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month .. month.at_end_of_month) }
  scope :by_item, ->(item_id) { where(store_order_item_id: item_id) }
  scope :tasks_of, ->(staff_id) { where(mechanic_id: staff_id) }

  def commission(beneficiary = 'person')
    workflow_snapshot.mechanic_commission.present? ? workflow_snapshot.mechanic_commission.task_commission(store_order_item, self, mechanic, beneficiary) : 0.0
  end

  def constructed_commission_template
    workflow_snapshot.mechanic_commission
  end

  def free
    self.mechanic.store_group_member.free!
  end

  def has_commission?
    workflow_snapshot.mechanic_commission.present?
  end

  def waste!
    self.update!(deleted: true)
  end

end
