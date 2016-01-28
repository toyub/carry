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
        params do
          optional :vehicle_brand_id, type: Integer, desc: "所属品牌ID"
        end
        add_desc "车系"
        get do
          series = VehicleSeries.where(vehicle_brand_id: params[:vehicle_brand_id])
          present series, with: ::Entities::VehicleBrand
        end
      end

      resource :models do
        params do
          optional :vehicle_series_id, type: Integer, desc: '所属车系的id'
        end
        add_desc "车型"
        get do
          models = VehicleModel.where(vehicle_series_id: params[:vehicle_series_id])
          present models, with: ::Entities::VehicleBrand
        end
      end

    end
  end
end
