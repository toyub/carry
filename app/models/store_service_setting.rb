class StoreServiceSetting < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service
  has_many :workflows, class_name: 'StoreServiceWorkflow', dependent: :delete_all

  validates :store_staff_id, presence: true

  accepts_nested_attributes_for :workflows, allow_destroy: true

  def workflow
    workflows.first
  end
end
