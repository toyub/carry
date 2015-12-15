class Tag::Base < ActiveRecord::Base
  self.table_name = 'tags'

  validates :name, presence: true, uniqueness: {scope: [:type, :store_id]}

  has_many :taggings, dependent: :destroy, foreign_key: :tag_id
end
