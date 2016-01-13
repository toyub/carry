require "grape-swagger"

module V1
  class Base < Grape::API

    include V1::Defaults

    mount V1::Users

    add_swagger_documentation mount_path: "/api-doc", api_version: "v1", hide_documentation_path: true, hide_format: false,
                              info: {title: "api接口文档", description: "v1.0"}

  end
end
