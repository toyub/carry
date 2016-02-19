class SmsSwitch
  def self.category
    [
      {name: 'SmsNotifySwitchType', cn_name: "提醒", sub_category:  SmsNotifySwitchType.collection },
      {name: 'SmsTrackingSwitchType', cn_name: "回访", sub_category:  SmsTrackingSwitchType.collection },
      {name: 'SmsCaptchaSwitchType', cn_name: "验证", sub_category:  SmsCaptchaSwitchType.collection },
    ]
  end
end
