class AddVehicleService
  include Serviceable
  include StatusObject

  attr_reader :customer, :vehicle, :plate

  def initialize(vehicle_params, plate_params, options = {})
    @customer_params = options[:customer_params]
    @vehicle_params = vehicle_params
    @plate_params = plate_params
    @customer = options[:customer]
  end

  def call
    ActiveRecord::Base.transaction do
      if @customer.blank?
        @customer ||= StoreCustomer.create!(@customer_params)
        entity = @customer.create_store_customer_entity(@plate_params.except(:license_number))
        entity.create_store_customer_settlement(@plate_params.except(:license_number))
      end
      @vehicle = StoreVehicle.create!(@vehicle_params.merge(store_customer_id: @customer.id))
      @plate = @vehicle.plates.create!(@plate_params)
    end
    Status.new(success: true, notice: '添加成功!', customer: @customer)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error e.message
    customer = StoreVehicleRegistrationPlate.where(license_number: @plate_params[:license_number]).first.try(:store_customer)
    Status.new(success: false, notice: e.message, customer: customer)
  end
end
