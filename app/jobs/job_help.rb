module JobHelp
  class StoreSms
    def self.check_sms(store)
      if store.blank?
        return {success: false, notice: "错误: 门店不存在"}
      end
      if store.sms_balance.blank?
        return {success: false, notice: "错误: 该门店未充值短信费用"}
      end
      if store.sms_balance.remaining < 0
        return {success: false, notice: "错误: 该门店短信费用不足"}
      end
      return {success: true, notice: "发送成功"}
    end
  end
end
