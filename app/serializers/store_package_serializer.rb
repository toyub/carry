class StorePackageSerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :abstract, :remark
end
