#Simple OA
module Soa
  class BaseController < ApplicationController
    before_filter :login_required

    def check_bonus
      @staffs = current_store.store_staff
        .by_keyword(params[:keyword])
        .by_level(params[:level_type_id])
        .by_job_type(params[:job_type_id])
      @staffs = @staffs.map do |staff|
        if staff.bonus.nil? || staff.skills.nil? || staff.other.nil?
          staff.update( bonus: {}, skills: {}, other: {} )
        end
      end
    end
  end
end
