class AuthenticateTokenService
  include Serviceable

  AUTH_URL = Setting.auth_host + "/apps"

  def initialize(key, secret)
    @key = key
    @secret = secret
  end

  def call
    response = HttpClient.get(AUTH_URL + "/#{@key}/auth", {secret: @secret}, {})
    return false if response.status != 200
    JSON.parse(response.body)["success"]
  end
end
