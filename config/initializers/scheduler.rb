require 'sidekiq/scheduler'
begin
  Sidekiq.schedule = YAML.load_file(File.expand_path("../../../config/scheduler.yml",__FILE__))
rescue NoMethodError => e
  puts "scheduler文件为空，#{e.message}"
end
