class StoreSubscribeOrder < ActiveRecord::Base
  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle, foreign_key: :vehicle_id

  enum state: %i[pending processing done]
  enum order_type: %i[auto]

  def fake_data
    [
      '2015-7-19',
      'YX2015071900001',
      '米其林轮胎',
      '2015/55/16 3ST 91V',
      '1,160.00',
      '喜欢该商品项目',
      '还要考虑一下',
      '2015-11-1',
      '',
      '王丽丽'
    ]
  end
end
