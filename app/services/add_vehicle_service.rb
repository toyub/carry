class AddVehicleService
  include Serviceable
  include StatusObject

  attr_reader :customer, :vehicle

  def initialize(store, vehicle_params, customer_params)
    if vehicle_params[:license_number].blank?
      vehicle_params[:provisional] = true if vehicle_params[:provisional].nil?
    end
    @store = store
    @chain = store.store_chain
    @customer_params = customer_params
    @vehicle_params = vehicle_params
  end

  def call
    begin
      ActiveRecord::Base.transaction do
        create_vehicle
      end
    rescue => e
      Rails.logger.info e
      Status.new(success: false, notice: '创建失败，请重试')
    end
  end

  private
  def create_vehicle
    if @vehicle_params[:provisional] #无牌开单
      create_provisional_vehicle
    else
      @vehicle = @chain.store_vehicles.regular_chain_mode.find_by(license_number: @vehicle_params[:license_number])
      if @vehicle.present?
        @customer = @vehicle.store_customer
        Status.new(success: true, notice: "车牌号为 #{@vehicle.license_number} 的车辆已经存在", customer: @customer, vehicle: @vehicle)
      else
        create_regular_vehicle
      end
    end
  end

  def find_or_create_customer
    if @customer_params[:phone_number].present?
      @customer = @chain.store_customers.regular_chain_mode.find_by(phone_number: @customer_params[:phone_number])
    end
    if @customer.blank?
      @customer = @store.store_customers.create_with_entity!(@customer_params)
    end
  end

  def create_regular_vehicle
    find_or_create_customer
    @vehicle = @customer.store_vehicles.create!(@vehicle_params)
    Status.new(success: true, notice: "车辆创建成功,车牌保存为: #{@vehicle.license_number}", customer: @customer, vehicle: @vehicle)
  end

  def create_provisional_vehicle
    find_or_create_customer
    @vehicle = @customer.store_vehicles.create!(@vehicle_params.merge(license_number: '暂无牌照'))
    Status.new(success: true, notice: '车辆创建成功,车辆暂无牌照', customer: @customer, vehicle: @vehicle)
  end
end
