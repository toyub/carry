class StaffTodo < ActiveRecord::Base
  belongs_to :creator, polymorphic: true

  validates :content, presence: true

  scope :done, -> { where(done: true) }
  scope :undone, -> { where(done: false) }
end
