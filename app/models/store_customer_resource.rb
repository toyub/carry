class StoreCustomerForm
  include ActiveModel::Model

  ENTITY_FIELDS = [:telephone, :qq, :district, :address, :range, :remark, :store_customer_category_id]
  CUSTOMER_FIELDS = [
    :first_name,
    :last_name,
    :gender,
    :nick,
    :resident_id,
    :birthday,
    :married,
    :education,
    :profession,
    :income,
    :company,
    :tracking_accepted,
    :message_accepted
  ]
  SETTLEMENT_FIELDS = [:bank, :bank_account, :credit, :credit_amount, :notice_period, :contract, :tax, :payment_mode, :invoice_title, :invoice_type]

  FIELDS = ENTITY_FIELDS + CUSTOMER_FIELDS + SETTLEMENT_FIELDS

  attr_accessor *FIELDS
  attr_reader :store_customer, :store_customer_settlement

  validates :first_name, presence: true
  validates :last_name, presence: true

  def initialize
    @entity = StoreCustomerEntity.new
  end

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def persist!
    @entity.transanction do
      @entity.attributes = self.attributes.slice(ENTITY_FIELDS)
      @entity.store_customer = StoreCustomer.build(self.attributes.slice(CUSTOMER_FIELDS))
      @entity.store_customer_settlement = StoreCustomerSettlement.build(self.attributes.slice(SETTLEMENT_FIELDS))
      @entity.save!
    end
  end

end
