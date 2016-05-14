module Api
  module Import
    class MaterialsController < Api::BaseController
      def index
        @materials = current_store.store_materials.select(:id, :name)
        render json: @materials.to_json
      end

      def create
        ::Import::StoreMaterialsService.new(params[:store_materials])
        render json: {success: true}
      end
    end
  end
end
