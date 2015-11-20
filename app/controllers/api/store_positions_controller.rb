module Api
  class StorePositionsController < BaseController
    def index
      department = StoreDepartment.find(params[:store_department_id])
      positions = department.store_positions
      respond_with positions, location: nil
    end

    def create
      position = StorePosition.new(append_store_attrs(position_params))
      position.save!
      render json: position, location: nil
    end

    def update
      position = StorePosition.find(params[:id])
      position.update!(position_params)
      render json: position, location: nil
    end

    private
    def position_params
      params.require(:store_position).permit(:name, :store_department_id)
    end
  end
end
