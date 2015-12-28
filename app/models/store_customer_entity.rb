class StoreCustomerEntity < ActiveRecord::Base
  include BaseModel

  has_one :store_customer
  has_one :store_customer_settlement

  accepts_nested_attributes_for :store_customer
  accepts_nested_attributes_for :store_customer_settlement

  PROPERTIES = {
    group: '集团客户',
    personal: '个人客户'
  }

  EDUCATIONS = {
    middle: '初中及以下',
    high: '高中或中专',
    academy: '专科',
    graduate: '本科',
    postgraduate: '硕士以上'
  }

  INCOMES = {
    low: '5000以下',
    middle: '5000 ~ 10000',
    upper: '10000 ~ 30000',
    high: '30000以上'
  }

  CREDIS = {
    unlimited: '不限金额',
    custom: '自定义',
    unpermitted: '不允许挂账'
  }

  SETTLEMENTS = {
    low: '月底前3天',
    middle: '月底前5天',
    high: '月底前7天'
  }

  PAYMENTS = {
    cash: '现金',
    check: '支票',
    credit: '信用卡',
    debit: '银行卡',
    alipay: '支付宝',
    wechat: '微信',
    hanging: '挂账'
  }

  INVOICES = {
    common: '普票',
    extra: '增值税发票'
  }

  def province
    self.district["province"]
  end

  def city
    self.district["city"]
  end

  def region
    self.district["region"]
  end

  def filling_date
    self.created_at.strftime("%Y-%m-%d")
  end

  def increase_balance!(amount)
    self.class.unscoped.where(id: self.id).update_all("balance=COALESCE(balance, 0) + #{amount.to_f.abs}")
  end

  def decrease_balance!(amount)
    self.class.unscoped.where(id: self.id).update_all("balance=COALESCE(balance, 0) - #{amount.to_f.abs}")
  end

end
