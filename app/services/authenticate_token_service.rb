class AuthenticateTokenService
  include Serviceable

  AUTH_URL = Setting.auth_host + "/apps"

  def initialize(key, secret)
    @key = key
    @secret = secret
  end

  def call
    Rails.cache.fetch cache_key do
      response = HttpClient.get(path, {secret: @secret}, {})
      return false if response.status != 200
      JSON.parse(response.body)["success"]
    end
  end

  def self.authenticate!(client_key)
    return false unless client_key.present?

    key, secret = client_key.split(":")
    self.new(key, secret).call
  end

  private
  def path
    AUTH_URL + "/#{@key}/auth"
  end

  def cache_key
    "app_auth_token:#{@key}:#{@secret}"
  end
end
