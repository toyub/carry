namespace :deploy do
  desc "install bundler"
  task :install_bundler do
    on roles(:all) do
      execute :sudo, "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do gem install bundler --no-ri --no-rdoc"
    end
  end

  desc "install nodejs"
  task :install_nodejs do
    on roles(:all) do
      execute :sudo, "apt-get -y install nodejs"
    end
  end

  desc "replace gem sources to taobao"
  task :change_gem_sources do
    on roles(:all) do
      execute :sudo, "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do gem sources -r https://rubygems.org/"
      execute :sudo, "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do gem sources -a https://ruby.taobao.org/"
    end
  end

  desc "rake db seed"
  task :db_seed do
    on roles(:db) do
      within current_path do
          execute :sudo, "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do rake db:seed RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end

  desc "install jekyll to build static assets"
  task :install_jekyll do
    on roles :web, :app do
      execute :sudo, "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do gem install jekyll --no-ri --no-rdoc"
    end
  end

  desc "set up"
  task :initial_setup do
    on roles(:all) do
      invoke 'deploy:change_gem_sources'
      invoke 'deploy:install_nodejs'
      invoke 'deploy:install_bundler'
      invoke 'deploy:install_jekyll'
      invoke 'monit:install'
      invoke 'monit:config'
    end


    on roles(:app) do
      invoke 'puma:monit:config'
      invoke 'puma:nginx_config'
      invoke 'puma:config'
    end
  end

  desc 'Initial Deploy'
  task :initial do
    after 'deploy:started', 'deploy:initial_setup'
    invoke 'deploy'
  end

end
