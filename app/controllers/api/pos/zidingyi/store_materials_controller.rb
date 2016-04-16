module Api
  module Pos
    module Zidingyi
      class StoreMaterialsController < Api::BaseController
        def index
          @store_materials = current_store.store_materials.order('id desc')
        end

        def show
        end
      end
    end
  end
end
