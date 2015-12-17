class Soa::ProtocolsController < Soa::BaseController
  def record
    @protocol = StoreProtocol.find(params[:id])
    @staff = @protocol.store_staff
    respond_to do |format|
      format.js
    end
  end
end
