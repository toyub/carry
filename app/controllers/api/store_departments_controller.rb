module Api
  class StoreDepartmentsController < BaseController
    def index
      departments = [
        {
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
  end
end
