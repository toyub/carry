class StorePackageSerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :abstract, :remark, :price, :recommended_price

  has_one :package_setting

  def recommended_price
    1
  end
end
