class Crm::StoreTrackingsController < ApplicationController
  before_action :set_customer

  def index
  end

  def set_customer
    @customer = StoreCustomer.find(params[:store_customer_id])
  end
end
