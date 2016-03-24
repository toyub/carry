class SmsRecord < ActiveRecord::Base
  belongs_to :store_customers

  scope :by_store, -> { where(party_type: 'Store') }
  scope :by_date, -> (start_date, end_date){ where(created_at: start_date .. end_date) }
  scope :by_category, ->(first_category, second_category) { where(first_category: first_category).where(second_category: second_category) }
  belongs_to :party, polymorphic: true

  FIRST_CATEGORY_CN_NAME = {
    'SmsCaptchaSwitchType': "验证",
    'SmsNotifySwitchType': "提醒",
    'SmsTrackingSwitchType': "回访"
  }
  def category_cn_name
    if FIRST_CATEGORY_CN_NAME.keys.include? first_category.try(:to_sym)
      FIRST_CATEGORY_CN_NAME[first_category.to_sym].to_s + ": " + first_category.constantize.find(second_category).try(:name)
    end
  end
end
