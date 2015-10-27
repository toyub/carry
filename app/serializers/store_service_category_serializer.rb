# == Schema Information
#
# Table name: store_service_categories
#
#  id             :integer          not null, primary key
#  created_at     :datetime
#  updated_at     :datetime
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  name           :string(45)       not null
#  store_staff_id :integer
#

class StoreServiceCategorySerializer < ActiveModel::Serializer
  attributes :id, :name
end
