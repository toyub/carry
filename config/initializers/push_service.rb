push_config = YAML.load_file("#{Rails.root}/config/push_service.yml")[Rails.env]

$ios_push_api = "http://" + push_config['host'] + ":" + push_config['port'].to_s + push_config['urls']['ios']
