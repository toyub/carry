class StoreCustomerSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_chain_id, :store_staff_id, :first_name, :last_name, :full_name,
             :created_at, :updated_at, :phone_number, :qq, :store_customer_category_id, :gender,
             :nick, :resident_id, :birthday, :married, :education, :profession, :income,
             :company, :tracking_accepted, :message_accepted, :store_customer_entity_id,
             :telephone, :remark, :account, :category_name, :category, :payment_mode,
             :property_i18n, :payment_mode_i18n, :membership

  def category_name
    object.store_customer_entity.store_customer_category.try(:name)
  end

  def category
    object.store_customer_entity.store_customer_category
  end

  def payment_mode
    object.store_customer_entity.try(:store_customer_settlement).try(:payment_mode)
  end

  def property_i18n
    object.store_customer_entity.try(:property_i18n)
  end

  def payment_mode_i18n
    object.store_customer_entity.try(:store_customer_settlement).try(:payment_mode_i18n)
  end

  def membership
    object.store_customer_entity.membership
  end
end
