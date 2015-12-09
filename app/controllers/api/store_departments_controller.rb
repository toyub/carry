module Api
  class StoreDepartmentsController < BaseController
    before_action :set_department, only: [:update, :children]
    def index
      respond_with current_store.store_departments.root_departments, location: nil
    end

    def create
      department = StoreDepartment.create(append_store_attrs(department_params))
      respond_with department, location: nil
    end

    def update
      @department.update(department_params)
      respond_with @department, location: nil
    end

    def children
      respond_with @department.children, location: nil
    end

    private
    def department_params
      params.require(:store_department).permit(:parent_id, :name)
    end

    def set_department
      @department = StoreDepartment.find(params[:id])
    end
  end
end
