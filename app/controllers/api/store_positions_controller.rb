module Api
  class StorePositionsController < BaseController
    def index
      positions = [{
          name: 'sadfdsaf',
          staff: [{screen_name: 'asdfsdf'}, {screen_name: 'sdfakdjfl'}]
        }]
      respond_with positions, location: nil
    end
  end
end
