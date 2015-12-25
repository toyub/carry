class Crm::StoreVehicleArchivesController < Crm::BaseController
  before_action :set_customer, except: [:index, :destroy]
  before_action :set_vehicle, only:[:show, :edit, :update]
  before_action :set_vehicle_ids, only: [:new, :show]

  def new
    @vehicle = StoreVehicle.new
    @vehicle.build_frame
  end

  def create
    vehicle = StoreVehicle.new(append_store_attrs vehicle_params.except(:license_number, :identification_number))
    if CreateStoreVehicleService.call(vehicle, vehicle_params)
      redirect_to crm_store_customer_store_vehicle_archive_path(@customer, vehicle)
    else
      @vehicle_ids = @customer.store_vehicles.ids
      @vehicle = StoreVehicle.new
      @vehicle.build_frame
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @vehicle.update(vehicle_params)
    redirect_to crm_store_customer_store_vehicle_archive_path
  end

  private

    def vehicle_params
      params.require(:store_vehicle).permit(
        :numero,
        :license_number,
        :identification_number,
        :vehicle_brand_id,
        :vehicle_series_id,
        :vehicle_model_id,
        detail: [
                 :organization_type,
                 :bought_on,
                 :ex_factory_date,
                 :maintained_at,
                 :maintained_mileage,
                 :maintain_interval_time,
                 :maintain_interval_mileage,
                 :next_maintain_mileage,
                 :next_maintain_at,
                 :color, :capacity,
                 :registered_on,
                 :mileage,
                 :annual_check_at,
                 :insurance_compnay,
                 :insurance_expire_at,
                 :next_maintain_customer_alermify,
                 :next_maintain_store_alermify,
                 :annual_check_customer_alermify,
                 :annual_check_store_alermify,
                 :insurance_customer_alermify,
                 :insurance_store_alermify
               ],
        frame_attributes:[:vin])
    end

    def set_customer
      @customer = StoreCustomer.find(params[:store_customer_id])
    end

    def set_vehicle
      @vehicle = @customer.store_vehicles.find(params[:id])
    end

    def set_vehicle_ids
      @vehicle_ids = @customer.store_vehicles.ids.sort
    end
end