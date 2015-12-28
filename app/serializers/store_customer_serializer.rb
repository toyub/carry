class StoreCustomerSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_chain_id, :store_staff_id, :first_name, :last_name, :full_name,
             :created_at, :updated_at, :phone_number, :qq, :store_customer_category_id, :gender,
             :nick, :resident_id, :birthday, :married, :education, :profession, :income,
             :company, :tracking_accepted, :message_accepted, :store_customer_entity_id,
             :telephone, :remark, :account
end