class StoreChain < ActiveRecord::Base
  has_many :stores
  belongs_to :head_office, class_name: 'Store', foreign_key: :admin_store_id
end

# == Schema Information
#
# Table name: store_chains
#
#  id             :integer          not null, primary key
#  admin_store_id :integer
#  admin_id       :integer
#  chain_enabled  :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#
