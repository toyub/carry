class StoreMaterialSaleinfoService < ActiveRecord::Base
  include BaseModel

  belongs_to :store_material
  belongs_to :store_material_saleinfo
  belongs_to :mechanic_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'mechanic_commission_template_id'
  has_many :snapshots, class_name: "StoreServiceSnapshot", as: :templateable
  has_many :store_order_items, as: :orderable
  has_many :store_staff_tasks, as: :taskable

  scope :available, ->{where(deleted: false)}

  scope :has_deleted, ->{where(deleted: true)}
  scope :not_deleted, ->{where(deleted: false)}

  # HACK: 商品中带的服务是没有施工提醒的，但是为了兼容服务，
  # 所以在这里hack了一下
  HACKED_SERVICE_REMINDS = {
    ordered: ->(service){"尊敬的客户您在本店购买的服务【#{service.name}】已经下单成功，即将开始施工。 <#{service.store.name}>"},
    started: ->(service){"尊敬的客户您在本店购买的服务【#{service.name}】已经开始施工，预计施工时间: #{service.standard_time}分钟。 <#{service.store.name}>"},
    finished: ->(service){"尊敬的客户您在本店购买的服务【#{service.name}】已经施工完成。 <#{service.store.name}>"}
  }


  def mechanic_level_type
    ServiceMechanicLevelType.find(self.mechanic_level).name
  end

  def to_snapshot!(order_item)
    service = StoreServiceSnapshot.create! self.base_attrs(order_item).merge(templateable: self, retail_price: 0)
    StoreServiceWorkflowSnapshot.create! self.base_attrs(order_item).merge(mechanic_commission_template_id: self.mechanic_commission_template_id, store_service_id: service.id, standard_time: self.standard_time)
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

  def category
    self
  end

  def standard_time
    (self.work_time_in_seconds/60.0).ceil
  end

  def delay_until
    tracking_delay_in_seconds.seconds
  end

  def commission(order_item, staff, beneficiary = 'person')
    0.0
  end

  #HACK: 商品中的服务是没有销售提成的
  def saleman_commission_template
    nil
  end

  #HACK: 是否启用施工提醒
  def sms_enabled?(remind_type)
    HACKED_SERVICE_REMINDS.keys.include?(remind_type) && self.tracking_needed
  end

  #HACK: 施工提醒内容
  def message(remind_type)
    if HACKED_SERVICE_REMINDS.keys.include?(remind_type)
      HACKED_SERVICE_REMINDS[remind_type].call(self)
    else
      ''
    end
  end

  #HACK: 施工提醒时间(节)点
  def remind_delay_interval(*args)
    (0.5).minutes
  end

end
