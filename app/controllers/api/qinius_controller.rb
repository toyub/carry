module Api
  class QiniusController < BaseController
    def upload_token
      put_policy = Qiniu::Auth::PutPolicy.new(params[:bucket] || 'zcmis')
      uptoken = 'UpToken' + ' ' + Qiniu::Auth.generate_uptoken(put_policy) #UpToken和token值之间必须有且仅有一个空格
      result = { uptoken: uptoken }
      respond_with result, location: nil
    end
  end
end
