begin
  $qiniu_config = YAML.load_file("#{Rails.root}/config/qiniu.yml").with_indifferent_access
  Qiniu.establish_connection! $qiniu_config[:access]
rescue Exception => e
  puts e.message
end
