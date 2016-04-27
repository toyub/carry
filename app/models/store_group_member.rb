class StoreGroupMember < ActiveRecord::Base
  include BaseModel
  belongs_to :store_group
  belongs_to :member, class_name: 'StoreStaff', foreign_key: 'member_id'
  enum work_status: %i[absence ready busy]
  has_many :store_staff_tasks
  has_many :workflow_snapshots, class_name: 'StoreServiceWorkflowSnapshot', through: :store_staff_tasks

  scope :available, ->{where(deleted: false)}
  scope :level_at_least, ->(level){where("COALESCE(level_type_id, 0) >= :level", level: level.to_i)}
  scope :order_by_update, ->{order('updated_at asc')}
  scope :attendances, ->{where.not(work_status: StoreGroupMember.work_statuses[:absence])}

  def self.count_by_work_statuses
    counts = self.group(:work_status).count(:id)
    {
      absence: counts[self.work_statuses[:absence]].to_i,
      ready: counts[self.work_statuses[:ready]].to_i,
      busy: counts[self.work_statuses[:busy]].to_i
    }
  end

  def current_busy_task
    self.store_staff_tasks.undeleted.busy.first
  end

  def current_processing_workflow
    workflow_snapshots.processing.first
  end

  def free!
    self.ready!
  end

  def set_deleted!
    self.deleted = true
    self.save!
  end

  def set_level_type_id
    self.level_type_id = self.member.level_type_id.to_i
    self.save!
  end

  def eligible_for?(workflow)
    return true if workflow.engineer_level.blank?
    workflow.engineer_level == self.member.level_type_id
  end
end
