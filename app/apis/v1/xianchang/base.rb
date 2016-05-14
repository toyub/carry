module V1
  module Xianchang
    class Base < Grape::API
      mount V1::Xianchang::StoreOrder
      mount V1::Xianchang::StoreWorkstation
    end
  end
end
