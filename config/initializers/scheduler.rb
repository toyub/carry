require 'sidekiq/scheduler'
begin
  Sidekiq.schedule = YAML.load_file("#{Rails.root}/config/scheduler.yml")[Rails.env]
rescue NoMethodError => e
  puts "scheduler文件为空，#{e.message}"
end
