json.array! @manufacturers do |manufacturer|
  json.(manufacturer, :id, :name)
  json.series manufacturer.vehicle_series, :id, :name
end
