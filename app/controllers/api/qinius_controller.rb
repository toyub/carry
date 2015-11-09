module Api
  class QiniusController < BaseController
    def upload_token
      bucket = params[:bucket] || 'zcmis'
      key = params[:key]
      expires_in = params[:expires_in] || 3600.seconds.value
      if Qiniu::Config.instance_variable_defined?(:@settings) && Qiniu::Config.instance_variable_get(:@settings)[:secret_key].present?
        put_policy = Qiniu::Auth::PutPolicy.new(bucket)
        uptoken = 'UpToken' + ' ' + Qiniu::Auth.generate_uptoken(put_policy) #UpToken和token值之间必须有且仅有一个空格
        result = { uptoken: uptoken }
      else
        result = {}
      end
      respond_with result, location: nil
    end

    def post_img_src
      p request.body
      render json: {md5: "#{Time.now.to_f}#{rand}#{rand}#{rand}"}
    end


  end
end
