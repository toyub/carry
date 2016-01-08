module Api
  module Osm

    class GroupsController < BaseController
      before_action :set_group, only: [:update, :show, :destroy]
      def index
        groups = current_store.store_groups.actived.order('id asc')
        respond_with groups, location: nil
      end

      def create
        group = current_store.store_groups.create(group_params)
        respond_with group, location: nil
      end

      def update
        @group.update(group_params)
        respond_with @group, location: nil
      end

      def show
        respond_with @group, location: nil
      end

      def destroy
        @group.soft_delete!
        respond_with @group, location: nil
      end

      private
      def group_params
        params.require(:group).permit(:name).merge(store_staff_id: current_staff.id)
      end

      def set_group
        @group = current_store.store_groups.find(params[:id])
      end
    end

  end
end
