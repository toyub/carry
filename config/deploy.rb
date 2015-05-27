# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'mis'
set :repo_url, 'git@git.icar99.com:/opt/git/wisdom/mis.git'
set :deploy_to, "/home/wisdom/#{application}"
set :scm, :git

set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :keep_releases, 5
set :deploy_via, :remote_cache

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
