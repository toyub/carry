namespace :store_service_remind do
  task :enumable_trigger_timing => :environment do
    ActiveRecord::Base.transaction do
      1.upto(3) do |i|
        StoreServiceRemind.where(trigger_timing: i).update_all(trigger_timing: i - 1)
      end
    end
  end
end
