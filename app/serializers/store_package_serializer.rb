class StorePackageSerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :abstract, :remark

  has_many :uploads, serializer: UploadSerializer
  #has_one :store_package_setting
end
