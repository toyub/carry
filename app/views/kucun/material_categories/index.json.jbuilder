json.array! @root_categories do |category|
  json.id category.id
  json.name category.name
  json.sub_category category.sub_categories do |sub|
    json.id sub.id
    json.name sub.name
  end
end
