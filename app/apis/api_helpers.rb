module APIHelpers

  # 认证用户
  def authenticate!
    # 如果token不存在，则返回没有得到token
    raise APIErrors::NoGetAuthenticate unless request.headers["Authorization"].present?
    raise APIErrors::AuthenticateFail unless current_user
  end

  # 设备的sn码
  def sn_code
    @header_sn_code ||= headers["X-Sn-Code"]
  end

  def current_user
    @current_user ||= begin
      header_token = request.headers["Authorization"]

      token = ApiToken.where(access_token: header_token, sn_code: sn_code).first

      # 如果token存在并且没有过期
      if token && !token.expired?
        # 如果临近过期时间，推迟过期时间
        token.refresh_expires_at! if token.expires_at - Time.now <= 3.days
        token.user
      else
        nil
      end
    end
  end

  # 对客户端提交的未正确进行UTF-8编码的数据进行编码
  def normalize_encode_params
    @env["rack.request.form_hash"] ||= {}
    encode_params_values params if request.form_data? && request.media_type == 'multipart/form-data'
  end

  # 迭代对 params 的 values 进行编码处理
  def encode_params_values(hash)
    return if hash.blank?
    hash.each do |k, v|
      if hash[k].is_a?(Hash)
        encode_params_values(hash[k])
      else
        hash[k].force_encoding(Encoding::UTF_8).encode! if hash[k].is_a?(String)
      end
    end
  end

end
