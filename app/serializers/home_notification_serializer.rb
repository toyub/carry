class HomeNotificationSerializer < ActiveModel::Serializer
  attributes :id, :extra_type_name, :sender_name, :receiver_name, :message_content, :status_i18n
end
