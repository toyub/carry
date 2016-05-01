module Api
  module Home
    module Notifications
      class EnvelopesController < BaseController
        def index
          render json: '{}'
        end

        def update
          envelope = Envelope.find(params[:id])
          envelope.update(envelope_params)
          respond_with envelope
        end

        def destroy
          envelope = Envelope.find(params[:id])
          envelope.deleted!
          respond_with envelope
        end

        private
        def envelope_params
          params.require(:envelope).permit(:status)
        end
      end
    end
  end
end