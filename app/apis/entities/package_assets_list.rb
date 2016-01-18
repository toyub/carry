module Entities
  class PackageAssetsList < Grape::Entity
    expose :id
    expose :package_name
  end
end
