source 'https://ruby.taobao.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

gem "pg"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '2.7.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '4.1.0'


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.2.6'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '0.4.1', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# 性能检测
#gem 'rack-mini-profiler'

# 缓存
gem 'redis', '~> 3.2.1'
gem "hiredis", "~> 0.6.0"
# Redis 命名空间
gem 'redis-namespace','~> 1.5.1'
# 将一些数据存放入 Redis
gem 'redis-objects', '1.1.0'

# YAML 配置信息
gem 'settingslogic', '~> 2.0.9'

# 队列
gem 'sidekiq', '3.3.4'
# Sidekiq Web
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'sidekiq-scheduler', '~> 1.1'

gem 'puma'

group :development do
  gem 'capistrano', '~> 3.3.0'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
  gem 'capistrano-sidekiq'
  gem 'quiet_assets'
  gem 'annotate'
  gem 'pry', "~> 0.9.12"
  gem 'pry-nav', "~> 0.2.3"
end

gem 'backbone-on-rails'

gem 'responders', '~> 2.0'

# json生成
gem 'active_model_serializers'

# Generates javascript file that defines all Rails named routes as javascript helpers
gem "js-routes"


#GEO
gem 'geo', git: 'git@gitlab.icar99.com:zc/geo.git', tag: 'v0.0.3'

# Object-based searching
gem 'ransack', '~> 1.6.6'

gem 'sass', '3.4.10'

# 文件上传
gem 'carrierwave'
gem 'carrierwave-base64'

# Paginator
gem "kaminari"

#Select2 for rails asset pipeline
#https://github.com/argerim/select2-rails
#Select2 is a jQuery based replacement for select boxes.
#https://github.com/select2/select2
#https://select2.github.io/examples.html
gem "select2-rails"
