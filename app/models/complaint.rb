class Complaint < ActiveRecord::Base
  belongs_to :creator, polymorphic: true
  belongs_to :store_customer
  belongs_to :store_vehicle

end
