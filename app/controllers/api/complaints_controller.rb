module Api
  class ComplaintsController < BaseController

    def new
      @store_order = StoreOrder.find(params[:store_order_id])
      vehicle = @store_order.store_vehicle.plates.last.license_number
      numero = @store_order.numero
      creator = @store_order.creator.full_name
      mechanic = @store_order.items.map{ |item| item.creator.full_name }
      vehicle_id = @store_order.store_vehicle.id
      render json: {vehicle: vehicle, numero: numero, creator: creator,
                    mechanic: mechanic, vehicle_id: vehicle_id}
    end

    def create
      # binding.pry
    end

  end
end
