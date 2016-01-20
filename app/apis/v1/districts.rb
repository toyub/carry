module V1
  class Districts < Grape::API

    resources :districts do
      before do
        authenticate_user!
      end

      add_desc '中国省市列表'

      get do
        present Geo.provinces('1').map{ |p| [p.code, p.name] }, with: ::Entities::District
      end
    end

  end
end
