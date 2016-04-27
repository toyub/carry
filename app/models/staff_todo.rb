class StaffTodo < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
end
