module Api
  module Osm

    class StaffController < BaseController
      def index
        staff = current_store.store_staff.where(job_type_id: JobType.find_by_name('技师').id)
        respond_with staff.map { |staffi| StaffWithGroupSerializer.new(staffi).as_json(root: nil) }, location: nil
      end

      def update
        staff = current_store.store_staff.find(params[:id])
        store_group_member = staff.store_group_member || staff.create_store_group_member
        store_group_member.update!(member_params)
        respond_with StaffWithGroupSerializer.new(staff).as_json(root: nil), location: nil
      end

      private
      def member_params
        params.require(:staff).permit(:store_group_id, :work_status).merge(store_staff_id: current_staff.id)
      end
    end

  end
end