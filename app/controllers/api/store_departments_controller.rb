module Api
  class StoreDepartmentsController < BaseController
    def index
      departments = [
        {
          id: 12,
          name: 'xxxxxx',
          departments: [
            {
              name: 'yyyyyy'
            },
            {
              name: 'dccccccccc'
            },
            {
              name: 'sdfklsdfjsdlfa'
            }
          ]
        },
        {
          name: 'xxcfsdkljwei',
          departments: [
            {
            name: 'sdafklajndflo'
            }
          ]
        }
      ]

      respond_with departments, location: nil
    end

    def create
      render json: department_params
    end

    def update
      render json: department_params
    end

    private
    def department_params
      params.require(:store_department).permit(:parent_id, :name)
    end
  end
end
