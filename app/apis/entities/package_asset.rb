module Entities
  class PackageAsset < Grape::Entity
    expose :id
    expose :package_name
  end
end
