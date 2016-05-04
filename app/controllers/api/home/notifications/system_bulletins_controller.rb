module Api
  module Home
    module Notifications
      class SystemBulletinsController < BaseController
        def index
          messages = current_staff.receiving_letters.system_bulletins.pending.all
          respond_with messages.map{|msg|
            HomeNotificationSerializer.new(msg).as_json(root:nil)
          }
        end
      end
    end
  end
end
