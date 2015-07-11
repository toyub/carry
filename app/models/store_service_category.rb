class StoreServiceCategory < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :store
end
