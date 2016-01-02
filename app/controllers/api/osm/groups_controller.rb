module Api
  module Osm

    class GroupsController < BaseController
      def index
        groups = current_store.store_groups.where(deleted: false).order('id asc')
        respond_with groups, location: nil
      end

      def create
        group = current_store.store_groups.create(group_params)
        respond_with group, location: nil
      end

      def update
        group = current_store.store_groups.find(params[:id])
        group.update(group_params)
        respond_with group, location: nil
      end

      private
      def group_params
        params.require(:group).permit(:name).merge(store_staff_id: current_staff.id)
      end
    end

  end
end
