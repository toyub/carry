role :app, %w{staging@115.29.208.119}
role :web, %w{staging@115.29.208.119}
role :db, %w{staging@115.29.208.119}
role :worker, %w{staging@115.29.208.119}

set :deploy_to, "/var/www/mis_staging"
set :html_deploy_to, "#{fetch(:deploy_to)}/html"

set :rvm_type, :system
set :rvm_ruby_version, '2.2.3'

#set :nginx_sites_enabled_path, "#{shared_path}/config"
#set :nginx_sites_available_path, "#{shared_path}/config"
set :nginx_server_name, "staging.store.icar99.com"
set :puma_init_active_record, false
set :puma_workers, 2

set :rails_env, "staging"

set :branch, 'staging'
set :html_branch, 'development'

set :sidekiq_role, :worker
set :monit_role, :all
