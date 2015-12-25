class StoreOrderSerializer < ActiveModel::Serializer
  attributes :id, :numero, :state, :amount, :packages, :services, :materials, :pay_status, :task_status

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
end
