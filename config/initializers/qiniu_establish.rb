if File.exist?("#{Rails.root}/config/qiniu.yml")
  qiniu_config = YAML.load_file("#{Rails.root}/config/qiniu.yml")
  Qiniu.establish_connection! access_key: qiniu_config["access"]['access_key'],
                              secret_key: qiniu_config["access"]['secret_key']
  puts "Qiniu SDK has established ..."
else
  puts 'Config file "qiniu.yml" not found under config folder'
end
