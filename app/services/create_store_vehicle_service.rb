class CreateStoreVehicleService
  include Serviceable

  def initialize(vehicle, license_number, identification_number)
    @vehicle = vehicle
    @license_number = license_number
    @identification_number = identification_number
  end

  def call
    @vehicle.transaction do
      @vehicle.save!
      if (plate = StoreVehicleRegistrationPlate.find_by(license_number: @license_number)).blank?
        plate = StoreVehicleRegistrationPlate.new(license_number: @license_number)
        plate.set_attrs({
                          store_id: @vehicle.store_id,
                          store_customer_id: @vehicle.store_customer_id,
                          store_chain_id: @vehicle.store_chain_id,
                          store_staff_id: @vehicle.store_staff_id
                        })
        plate.save!
      end

      if (engine = StoreVehicleEngine.find_by(identification_number: @identification_number)).blank?
        engine = StoreVehicleEngine.new(identification_number: @identification_number)
        engine.set_attrs({
                          store_id: @vehicle.store_id,
                          store_customer_id: @vehicle.store_customer_id,
                          store_chain_id: @vehicle.store_chain_id,
                          store_staff_id: @vehicle.store_staff_id
                        })
        engine.save!
      end
      @vehicle.plates << plate
      @vehicle.engines << engine
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

end
