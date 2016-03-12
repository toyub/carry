json.(@store_order,
  :license_number,
  :numero,
  :creator,
  :store_vehicle_id
)

result = []
@store_order.items.each do |item|
  item.store_service_workflow_snapshots.each do |service_workflow|
    service_workflow.mechanics.each do |mechanic|
       result << {name: mechanic.full_name, id: mechanic.id }
    end
  end
end
json.mechanics result.uniq
