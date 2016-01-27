NullObject = Naught.build

NullSmsBalance = Naught.build do |b|
 b.mimic SmsBalance
 def sent_quantity;end
 def total_fee;end
end
