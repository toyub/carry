class AddVehicleForIpadService
  include Serviceable
  include StatusObject

  attr_reader :customer, :vehicle, :plate

  def initialize(vehicle_params, plate_params, options = {})
    @customer_params = options[:customer_params]
    @vehicle_params = vehicle_params
    @plate_params = plate_params
    @customer = options[:customer]
    binding.pry
  end

  def call
    ActiveRecord::Base.transaction do
      @customer ||= StoreCustomer.create!(@customer_params)
      @vehicle = StoreVehicle.create!(@vehicle_params.merge(store_customer_id: @customer.id))
      @plate = @vehicle.plates.create!(@plate_params.merge(store_customer_id: @customer.id))
    end
    Status.new(success: true, notice: '添加成功!', customer: @customer)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error e.message
    customer = StoreVehicleRegistrationPlate.where(license_number: @plate_params[:license_number]).first.store_customer
    Status.new(success: false, notice: e.message, customer: customer)
  end
end
