class StoreMaterialSaleinfoService < ActiveRecord::Base
  include BaseModel
  
  belongs_to :store_material
  belongs_to :store_material_saleinfo
  belongs_to :mechanic_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'mechanic_commission_template_id'
  has_many :snapshots, class_name: "StoreServiceSnapshot", as: :templateable
  has_many :store_order_items, as: :orderable

  default_scope {where(deleted: false).order('id asc')}

  def mechanic_level_type
    ServiceMechanicLevelType.find(self.mechanic_level).name
  end

  def to_snapshot!(order_item)
    service = StoreServiceSnapshot.create! self.base_attrs(order_item).merge(templateable: self, retail_price: 0)
    StoreServiceWorkflowSnapshot.create! self.base_attrs(order_item).merge(store_service_id: service.id, standard_time: self.standard_time)
  end

  def base_attrs(order_item)
    self.attributes.symbolize_keys.slice(
      :store_id,
      :store_chain_id,
      :store_staff_id,
      :name
    ).merge(
      store_vehicle_id: order_item.store_order.store_vehicle_id,
      store_order_item_id: order_item.id,
      store_order_id: order_item.store_order.id
    )
  end

  def retail_price
    0
  end

  def vip_price
    0
  end

  def standard_time
    (self.work_time_in_seconds/60.0).ceil
  end

  def delay_until
    tracking_delay_in_seconds.seconds
  end

  def commission(order_item)
    0
  end

end
