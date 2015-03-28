class Kucun::MaterialServicesController < Kucun::ControllerBase
   def create
    
    render json: params.merge({id: 23})
   end

   def destroy
    render json: params
   end
end