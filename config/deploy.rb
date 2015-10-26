# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'mis'
set :repo_url, 'git@gitlab.icar99.com:zc/mis.git'
set :deploy_to, "/home/wisdom/mis"
set :scm, :git

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/redis.yml', 'config/config.yml', 'config/initializers/secret_token.rb', '.ruby-version')
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/uploads')
set :keep_releases, 5
set :deploy_via, :remote_cache
set :pty, true

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/deploy`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc "load schema"
  task :load_schema do
    on roles(:db) do
      within current_path do
        execute :bundle, "exec rake", "db:schema:load", "RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end

  before 'deploy:migrate', :load_schema
  #before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
