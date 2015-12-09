class StoreMaterialUnit < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_chain
end
