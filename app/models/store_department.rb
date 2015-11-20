class StoreDepartment < ActiveRecord::Base
  include BaseModel
  has_many :store_positions
  belongs_to :parent, class_name: 'StoreDepartment'
  has_many :children, class_name: 'StoreDepartment', foreign_key: :parent_id

  validates_presence_of :name
  validates :parent, presence: true, unless: ->(m){m.parent_id == 0}

end
