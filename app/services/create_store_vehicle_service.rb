class CreateStoreVehicleService
  include Serviceable

  def initialize(vehicle, vehicle_params)
    @vehicle = vehicle
    @license_number = vehicle_params[:license_number]
    @identification_number = vehicle_params[:identification_number]
    @plate = StoreVehicleRegistrationPlate.find_by(license_number: @license_number)
    @engine = StoreVehicleEngine.find_by(identification_number: @identification_number)
  end

  def call
    @vehicle.transaction do
      @vehicle.save!
      @plate ||= StoreVehicleRegistrationPlate.create! plate_attr
      @engine ||= StoreVehicleEngine.create! engine_attr
      @plate.update!(store_customer_id: @vehicle.store_customer_id) if @plate.store_customer_id != @vehicle.store_customer_id
      @engine.update!(store_customer_id: @vehicle.store_customer_id) if @engine.store_customer_id != @vehicle.store_customer_id
      @vehicle.plates << @plate
      @vehicle.engines << @engine
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def vehicle_attrs
    @vehicle.attributes.symbolize_keys.slice(:store_id, :store_customer_id, :store_chain_id, :store_staff_id)
  end

  def plate_attr
    vehicle_attrs.merge(license_number: @license_number)
  end

  def engine_attr
    vehicle_attrs.merge(identification_number: @identification_number)
  end

end
