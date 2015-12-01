json.array! @customers do |customer|
  json.(customer, :id, :full_name, :mobile, :satisfaction, :integrity)
end
