module APIErrors
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.send(:include_errors)
  end

  VerifyFail = Class.new StandardError
  AuthenticateFail = Class.new StandardError
  NoVisitPermission = Class.new StandardError
  NoGetAuthenticate = Class.new StandardError

  module ClassMethods

    def include_errors

      rescue_from :all do |e|
        Rails.logger.error "#{e.message}\n\n#{e.backtrace.join("\n")}"
        out_error(code: 500, msg: e.message)
      end

      #rescue_from VerifyFail do |e|
        #out_error(code: 1001, msg: e.message || "失败")
      #end

      #rescue_from NoVisitPermission do |e|
        #out_error(code: 1002, msg: "无访问权限")
      #end

      rescue_from AuthenticateFail do |e|
        out_error(code: 401, msg: "没有访问权限，请重新登录")
      end

      #rescue_from ActiveRecord::RecordNotFound do |e|
        #out_error(code: 1004, msg: "没有找到相关数据")
      #end

      #rescue_from ActiveRecord::RecordInvalid do |e|
        #out_error(code: 1005, msg: e.message)
      #end

      #rescue_from Grape::Exceptions::ValidationErrors do |e|
        #out_error(code: 1006, msg: e.message || "输入内容格式有误")
      #end

      rescue_from NoGetAuthenticate do |e|
        out_error(code: 401, msg: "没有在header中得到token参数")
      end


    end

  end
end
