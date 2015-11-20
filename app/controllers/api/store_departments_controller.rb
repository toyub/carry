module Api
  class StoreDepartmentsController < BaseController
    def index
      store = current_store
      departments = store.store_departments.where(parent_id: 0)

      respond_with departments, location: nil
    end

    def create
      department = StoreDepartment.new(append_store_attrs(department_params))
      department.save!
      render json: department, location: nil
    end

    def update
      department = StoreDepartment.find(params[:id])
      department.update!(department_params)
      render json: department, location: nil
    end

    def children
      department = StoreDepartment.find(params[:id])
      departments = department.children
      respond_with departments, location: nil
    end

    private
    def department_params
      params.require(:store_department).permit(:parent_id, :name)
    end
  end
end
