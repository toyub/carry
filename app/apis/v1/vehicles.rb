module V1
  class Vehicles < Grape::API
    before do
      authenticate_user!
    end

    resource :vehicles do
      resource :brands do
        add_desc "车品牌"
        get do
          present VehicleBrand.all, with: ::Entities::VehicleBrand
        end
      end

      resource :series do
        add_desc "车系"
        get do
          present VehicleSeries.all, with: ::Entities::VehicleBrand
        end
      end

      resource :models do
        add_desc "车型"
        get do
          present VehicleModel.all, with: ::Entities::VehicleBrand
        end
      end

    end
  end
end
