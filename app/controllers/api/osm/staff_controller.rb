module Api
  module Osm
    class StaffController < BaseController
      def index
        staff = current_store.store_staff.where(job_type_id: JobType.find_by_name('技师').id)
        respond_with staff, location: nil
      end 
    end
  end
end