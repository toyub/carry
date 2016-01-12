class StoreVehicleBrandSerializer < ActiveModel::Serializer
  attr_accessor :data
  attributes :id, :created_at, :name

  def initialize
    @data = {
      brands: [],
      number: []
    }
    VehicleBrand.all.each do |brand|
      @data[:brands] << brand.name # ["其他","奥迪","马自达","日产","本田","奔驰","宝马","丰田","大众"]·
      @data[:number] << brand.store_vehicles.count # [289,299,360,400,450,500,550,600,700]
    end
  end
end
