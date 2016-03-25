json.array! @categories do |c|
  json.(c, :id, :name)
  json.sub_categories c.sub_categories, :id, :name
end
