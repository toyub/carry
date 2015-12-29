class StoreServiceSnapshot < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service_category
  has_many :store_service_store_materials
  has_many :store_materials, through: :store_service_store_materials
  belongs_to :unit, foreign_key: 'store_service_unit_id'
  has_one :store_order_item, as: :orderable
  has_many :store_service_workflows
  has_many :workflow_snapshots, class_name: 'StoreServiceWorkflowSnapshot', foreign_key: :store_service_id

  validates :name, presence: true
  validates :code, presence: true
  validates :retail_price, presence: true
  validates :store_service_category_id, presence: true
  validates :store_staff_id, presence: true

end
