class Crm::StoreVehiclesController < Crm::BaseController
  before_action :set_customer, except: [:index]
  before_action :set_vehicle, only:[:show, :edit, :update]
  before_action :set_vehicle_ids, only: [:new, :show]

  def index
    params[:q] ||= {}
    @q = current_store.store_vehicles.ransack(params[:q])
    @vehicles = @q.result
    # binding.pry
  end

  def new
    @vehicle = StoreVehicle.new
  end

  def create
    vehicle = StoreVehicle.new(append_attrs(vehicle_params, store_option, staff_option))
    if vehicle.save
      redirect_to crm_store_customer_store_vehicle_path(@customer, vehicle)
    else
      @vehicle_ids = @customer.store_vehicles.ids
      @vehicle = StoreVehicle.new
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @vehicle.update!(vehicle_params)
    redirect_to crm_store_customer_store_vehicle_path
  end

  private

    def vehicle_params
      wild_params = params.require(:store_vehicle)
      if wild_params[:frame_attributes].present?
        wild_params[:frame_attributes][:store_staff_id] = current_staff.id
      end

      if wild_params[:engines_attributes].present?
        wild_params[:engines_attributes].each_with_index do |eattrs,idx|
          wild_params[:engines_attributes][idx.to_s][:store_staff_id] = current_staff.id
        end
      end

      wild_params.permit :vehicle_brand_id,
                        :vehicle_series_id,
                        :vehicle_model_id,
                        :license_number,
                        detail: [
                                 :numero,
                                 :organization_type,
                                 :bought_on,
                                 :ex_factory_date,
                                 :maintained_at,
                                 :maintained_mileage,
                                 :maintain_interval_time,
                                 :maintain_interval_mileage,
                                 :next_maintain_mileage,
                                 :next_maintain_at,
                                 :color,
                                 :capacity,
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
                        frame_attributes: [:vin, :store_staff_id],
                        engines_attributes: [:identification_number, :store_staff_id]
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
