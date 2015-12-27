class StoreWorkstation < ActiveRecord::Base
  include BaseModel

  belongs_to :store_workstation_category
  belongs_to :current_workflow, class_name: 'StoreServiceWorkflowSnapshot', foreign_key: :workflow_id

  validates :name, presence: true, uniqueness: true
end
