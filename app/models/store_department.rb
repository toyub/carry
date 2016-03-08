class StoreDepartment < ActiveRecord::Base
  include BaseModel
  has_many :store_positions
  belongs_to :parent, class_name: 'StoreDepartment'
  has_many :children, class_name: 'StoreDepartment', foreign_key: :parent_id
  has_many :store_commission_items, as: :ownerable
  has_many :store_commissions, as: :ownerable

  validates_presence_of :name
  validates :parent, presence: true, unless: ->(m){m.parent_id == 0}

  scope :root_departments, ->(){where(parent_id: 0)}
  
end
