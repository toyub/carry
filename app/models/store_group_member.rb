class StoreGroupMember < ActiveRecord::Base
  include BaseModel
  belongs_to :store_group
  belongs_to :member, class_name: 'StoreStaff', foreign_key: 'member_id'
  enum work_status: %i[absence ready busy]

  def self.count_by_work_statuses
    counts = self.group(:work_status).count(:id)
    {
      absence: counts[self.work_statuses[:absence]].to_i,
      ready: counts[self.work_statuses[:ready]].to_i,
      busy: counts[self.work_statuses[:busy]].to_i
    }
  end

  def free!
    self.ready!
  end

  def eligible_for?(workflow)
    return true if workflow.engineer_level.blank?
    workflow.engineer_level == self.member.level_type_id
  end
end
