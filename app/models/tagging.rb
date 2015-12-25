class Tagging < ActiveRecord::Base
  validates :tag_id, presence: true
  validates :taggable_type, presence: true

  validates :taggable_id, presence: true, uniqueness: {scope: [:taggable_type, :tag_id]}

  belongs_to :tag, class_name: 'Tag::Base'
  belongs_to :taggable, polymorphic: true
end
