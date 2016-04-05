NullObject = Naught.build

NullSmsBalance = Naught.build do |b|
 b.mimic SmsBalance
 def sent_quantity;end
 def total_fee;end
end

NullStoreServiceRemind = Naught.build do |b|
  b.black_hole
  b.define_explicit_conversions

  def enabled?
    false
  end

  def message
    ''
  end

  def delay_interval
    0
  end
end
