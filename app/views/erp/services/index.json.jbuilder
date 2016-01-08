json.array! @services do |service|
  json.(service, :id, :name, :code, :time, :retail_price, :bargain_price, :point, :mechanic_levles, :saled, :category)
  json.unit service.unit.try(:name)
end
