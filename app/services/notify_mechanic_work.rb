require 'net/http'

class NotifyMechanicWork
  def initialize(mechanic, msg)
    @mechanic = mechanic
    @msg = msg
    notify_mechanic
  end

  def notify_mechanic
    uri = URI($ios_push_api)
    arguments = {
      device_token: @mechanic.device_token,
      msg: @msg
    }
    uri.query = URI.encode_www_form(arguments)
    Net::HTTP.get_response(uri)
  end
end
