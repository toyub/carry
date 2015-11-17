module Api
  class QiniusController < BaseController
    def upload_token
      respond_with token, location: nil
    end

    private
      def token
        policy = Qiniu::Auth::PutPolicy.new(params[:bucket] || 'zcmis')
        { uptoken: 'UpToken' + ' ' + Qiniu::Auth.generate_uptoken(policy) }
      end
  end
end
