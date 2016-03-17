require "redis"
require "redis-namespace"
require "redis/objects"


redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]

$redis = Redis::Namespace.new("#{Rails.env}_mis", redis: Redis.new(host: redis_config['host'], port: redis_config['port']))
Redis::Objects.redis = $redis

sidekiq_url = "redis://#{redis_config['host']}:#{redis_config['port']}/0"
Sidekiq.configure_server do |config|
  config.redis = { namespace: "#{Rails.env}_sidekiq", url: sidekiq_url }
end
Sidekiq.configure_client do |config|
  config.redis = { namespace: "#{Rails.env}_sidekiq", url: sidekiq_url }
end

SIDEKIQ = (YAML.load_file("#{Rails.root}/config/sidekiq_web.yml") rescue {}).deep_symbolize_keys
