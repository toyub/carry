namespace :deploy do
  desc "install bundler"
  task :install_bundler do
    on roles(:all) do
      execute :sudo, "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do gem install bundler --no-ri --no-rdoc"
    end
  end

  desc "install nodejs"
  task :install_nodejs do
    on roles(:app) do
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

  desc "set up"
  task :initial_setup do
    on roles(:all) do
      invoke 'deploy:change_gem_sources'
      invoke 'deploy:install_bundler'
      invoke 'monit:install'
      invoke 'monit:config'
    end

    on roles(:app) do
      invoke 'deploy:install_nodejs'
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
