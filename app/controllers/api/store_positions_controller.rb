module Api
  class StorePositionsController < BaseController
    def index
      department = StoreDepartment.find(params[:store_department_id])
      respond_with department.store_positions, location: nil
    end

    def create
      position = StorePosition.create(append_store_attrs(position_params))
      respond_with position, location: nil
    end

    def update
      position = StorePosition.find(params[:id])
      position.update(position_params)
      respond_with position, location: nil
    end

    private
    def position_params
      params.require(:store_position).permit(:name, :store_department_id)
    end
  end
end
