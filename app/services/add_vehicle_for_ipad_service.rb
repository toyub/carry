class AddVehicleForIpadService
  include Serviceable

  attr_reader :customer, :vehicle, :plate

  def initialize(customer_params, vehicle_params, plate_params)
    @customer_params = customer_params
    @vehicle_params = vehicle_params
    @plate_params = plate_params
  end

  def call
    ActiveRecord::Base.transaction do
      @customer = StoreCustomer.create!(@customer_params)
      @vehicle = StoreVehicle.create!(@vehicle_params.merge(store_customer_id: @customer.id))
      @plate = @vehicle.plates.create!(@plate_params.merge(store_customer_id: @customer.id))
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error e.message
    false
  end
end
