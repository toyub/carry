json.array! @provinces do |code, name|
  json.code code
  json.name name
  json.cities Geo.cities('1', code).map{ |c|[c.code, c.name] } do |code, name|
    json.code code
    json.name name
  end
end
