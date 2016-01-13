class StoreChain < ActiveRecord::Base
  has_many :stores
  belongs_to :head_office, class_name: 'Store', foreign_key: :admin_store_id

  has_many :store_customers
  has_many :plates, class_name: 'StoreVehicleRegistrationPlate'
  has_many :store_services
end
