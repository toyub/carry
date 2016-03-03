class StoreStaffTask < ActiveRecord::Base
  include BaseModel

  belongs_to :store_staff
  belongs_to :workflow, class_name: 'StoreServiceWorkflowSnapshot', foreign_key: :workflow_id
end
