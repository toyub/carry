class StorePackage < ActiveRecord::Base
  include BaseModel

  has_many :uploads, class_name: '::Upload::StorePackage', as: :fileable
end
