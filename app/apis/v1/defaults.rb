Dir["#{Rails.root}/app/apis/grape/*.rb"].each {|pi| require pi }

module V1
  module Defaults
    extend ActiveSupport::Concern

    included do


      prefix "apis"
      version 'v1', using: :path
      format :json
      content_type :json, 'application/json;charset=UTF-8'
      default_format :json
      #formatter :json, BodyFormatter
      #error_formatter :json, ErrorFormatter
      helpers APIHelpers


      include APIErrors

      # 调用接口时验证api_key
      before do
        raise APIErrors::NoVisitPermission unless request.path =~ /\/api-doc/ || Rails.env == 'development' || AuthenticateTokenService.authenticate!(headers["X-Client-Key"])
        I18n.locale = 'zh-CN'
      end
    end
  end
end
