class StoreMessage
  attr :sender_type, :sender_id
  def created_at
    @created_at ||= rand(30).days.ago
  end

  def title
  end

  def content
    '候名洋，您好，您的储值卡车储500卡使用30.0元，剩余297.0元，用于支付30水釉被膜洗车'
  end
end