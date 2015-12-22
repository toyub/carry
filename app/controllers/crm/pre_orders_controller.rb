class Crm::PreOrdersController < ApplicationController
  before_action :set_customer

  def index
    q = VehiclePlate.ransack(params[:q])
    @vehicle = q.result(distinct: true).order('created_at desc').first.store_vehicle
    @pre_order = StoreSubscribeOrder.new
  end

  private

    def set_customer
      @customer = StoreCustomer.find(params[:store_customer_id])
    end
end
