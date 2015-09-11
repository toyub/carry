module Xiaoshou
  module Service
    class WorkflowsController < Xiaoshou::BaseController
      before_action :set_service

      def show
        @workflow = StoreServiceWorkflowDecorator.new(@service.store_service_workflows.find(params[:id]))
      end

      private

      def set_service
        @service = current_store.store_services.find(params[:setting_id])
      end

    end
  end
end
