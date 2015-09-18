class StoreMaterialBrand < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_staff

end
