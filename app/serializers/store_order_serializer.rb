class StoreOrderSerializer < ActiveModel::Serializer
  attributes :id, :numero, :state, :amount, :packages, :services, :materials, :pay_status, :task_status,
    :created_at, :updated_at, :items_content, :state_i18n, :pay_status_i18n, :paid, :human_readable_status, :situation

  has_many :payments
  has_one :store_vehicle
  has_one :store_customer

  def materials
    {
      amount: object.items.materials.collect { |material| material.amount }.sum,
      items: object.items.materials.map { |material| StoreOrderItemSerializer.new(material).as_json(root: nil) }
    }
  end

  def packages
    {
      amount: object.items.packages.collect { |package| package.amount }.sum,
      items: object.items.packages.map { |package| StoreOrderItemSerializer.new(package).as_json(root: nil) }
    }
  end

  def services
    {
      amount: object.items.services.collect { |service| service.amount }.sum,
      items: object.items.services.map { |service| StoreOrderItemSerializer.new(service).as_json(root: nil) }
    }
  end

  def created_at
    object.created_at.strftime("%Y-%m-%d %H:%M")
  end

  def updated_at
    object.updated_at.strftime("%Y-%m-%d %H:%M")
  end

  def items_content
    if object.items.present?
      "包含 #{object.items.first.orderable.try(:name)} 等 #{object.items.count} 个项目 "
    else
      "包含0个项目"
    end
  end

  def paid
    object.paid?
  end

end
