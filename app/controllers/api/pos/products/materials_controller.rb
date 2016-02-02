module Api
  module Pos
    module Products
      class MaterialsController < Api::BaseController
        def index
          @materials = current_store.store_material_saleinfos.page(params[:page])
        end
      end
    end
  end
end
