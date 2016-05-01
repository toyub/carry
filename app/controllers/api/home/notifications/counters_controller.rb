module Api
  module Home
    module Notifications
      class CountersController < BaseController
        def index
          counters = current_staff.receiving_letters.group(:extra_type).count(:id).map{|key, value| {type: key, counter: value}}
          render json: counters
        end
      end
    end
  end
end