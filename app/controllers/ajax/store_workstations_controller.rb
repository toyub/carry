module Ajax
  class StoreWorkstationsController < Ajax::BaseController

    def index
      @workstations = current_store.store_workstation_categories.find(params[:store_workstation_category_id]).store_workstations.order("created_at desc")
    end

  end
end
