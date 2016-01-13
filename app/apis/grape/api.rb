module Grape
  class API
    class << self
      # 文档中需要填写header信息时使用
      def add_desc(desc, options={})
        desc "#{desc}", {
          headers: {
            "Authorization" => {
              description: "用户token",
              required: false
            },
            "X-SN-Code" => {
              description: "设备唯一识别码",
              required: false
            },
            "X-Client-Key" => {
              description: "访问权限",
              required: false
            }
          }
        }.merge(options)
      end
    end
  end
end

module Grape
  module Middleware
    class Error

      # 将默认错误返回状态码改为200
      def out_error(message={})
        error = {
          message: message,
          status: 200
        }
        error_response(error)
      end

    end
  end
end
