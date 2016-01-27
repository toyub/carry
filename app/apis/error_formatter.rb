module ErrorFormatter
  def self.call(message, backtrace, options, env)

    return message.to_json if message.is_a?(Hash) and message.has_key?(:swaggerVersion)

    result = {
      status: 0,
      error: message
    }

    result.to_json
  end
end
