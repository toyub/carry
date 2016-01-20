require "grape-swagger"

module V1
  class Base < Grape::API

    include V1::Defaults

    mount V1::Customers
    mount V1::CustomerProperties
    mount V1::ContactWays
    mount V1::MessageRecords
    mount V1::MessageBalances
    mount V1::MessageCategories
    mount V1::Districts
    # mount V1::Stores

    add_swagger_documentation mount_path: "/api-doc", api_version: "v1", hide_documentation_path: true, hide_format: false,
                              info: {title: "api接口文档", description: "v1.0"}

  end
end
