role :app, %w{deploy@121.40.229.244 deploy@114.215.198.108}
role :web, %w{deploy@121.40.229.244 deploy@114.215.198.108}
role :db,  %w{deploy@121.40.229.244}
role :worker,  %w{deploy@120.26.85.169}

set :deploy_to, "/var/www/mis"
set :html_deploy_to, "#{fetch(:deploy_to)}/html"

set :rvm_type, :system
set :rvm_ruby_version, '2.2.3'

#set :nginx_sites_enabled_path, "#{shared_path}/config"
#set :nginx_sites_available_path, "#{shared_path}/config"
set :nginx_server_name, "store.icar99.com md.icar99.com"
set :puma_init_active_record, true

set :rails_env, "production"

set :branch, 'master'
set :html_branch, 'development'

set :sidekiq_role, :worker
set :monit_role, :all
