class HomeNotificationCounterSerializer
  def initialize(count_key, count_value)
    @key = count_key
    @value = count_value
  end

  def extra_type_name
    I18n.t @key.to_s.underscore, scope: [:activerecord, :models]
  end

  def as_json(*args)
    {
      type: @key,
      counter: @value,
      extra_type_name: self.extra_type_name
    }
  end

  def to_json(*args)
    as_json(*args).to_json
  end
end
