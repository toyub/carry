json.array! @materials do |m|
  json.(m, :id, :name, :retail_price, :cost_price, :category_id, :root_category_id)
end
