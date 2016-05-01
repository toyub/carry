module Api
  module Home
    module Notifications
      class CountersController < BaseController
        def index
          counters = current_staff.receiving_letters.group(:extra_type).count(:id).map{|key, value| HomeNotificationCounterSerializer.new(key, value).as_json }
          render json: counters
        end
      end
    end
  end
end