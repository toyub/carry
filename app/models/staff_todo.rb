class StaffTodo < ActiveRecord::Base
  belongs_to :creator, polymorphic: true

  validates :content, presence: true
end
