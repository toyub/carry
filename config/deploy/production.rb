role :app, %w{deploy@114.215.198.108}
#role :app, %w{deploy@121.40.229.244 deploy@114.215.198.108}
role :db,  %w{deploy@114.215.198.108}
#role :worker,  %w{deploy@120.26.85.169}

set :deploy_to, "/var/www/mis"

set :rvm_type, :system
set :rvm_ruby_version, '2.2.2'

set :nginx_sites_enabled_path, "#{shared_path}/config"
set :nginx_sites_available_path, "#{shared_path}/config"
set :nginx_server_name, "com.icar99.store"
set :puma_init_active_record, true

set :rails_env, "production"

set :branch, 'deploy'
