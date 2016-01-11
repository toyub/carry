class StoreChain < ActiveRecord::Base
  has_many :stores
  has_many :store_departments
  has_many :store_positions
  has_many :store_staff, through: :stores
  has_many :store_customers
  belongs_to :head_office, class_name: 'Store', foreign_key: :admin_store_id
end
