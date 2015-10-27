class StoreMaterialSaleinfo  <  ActiveRecord::Base
  belongs_to :store_material
end

# == Schema Information
#
# Table name: store_material_saleinfos
#
#  id                 :integer          not null, primary key
#  store_id           :integer          not null
#  store_chain_id     :integer          not null
#  store_staff_id     :integer          not null
#  store_material_id  :integer          not null
#  bargainable        :boolean          default(FALSE)
#  bargain_price      :decimal(10, 2)   default(0.0), not null
#  retail_price       :decimal(10, 2)   default(0.0), not null
#  trade_price        :decimal(10, 2)   default(0.0), not null
#  reward_points      :integer          default(0)
#  divide_to_retail   :boolean          default(FALSE)
#  unit               :integer
#  volume             :decimal(10, 2)
#  service_needed     :boolean          default(FALSE)
#  service_fee_needed :boolean          default(FALSE)
#  service_fee        :decimal(10, 2)
#  created_at         :datetime
#  updated_at         :datetime
#
