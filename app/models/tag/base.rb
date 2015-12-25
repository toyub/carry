class Tag::Base < ActiveRecord::Base
  self.table_name = 'tags'
  include BaseModel
  has_many :taggings, dependent: :destroy, foreign_key: :tag_id

  validates :name, presence: true, uniqueness: {scope: [:type, :store_id]}
end
