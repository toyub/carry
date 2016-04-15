json.(@complaint,
  :license_number,
  :created_at_format,
  :numero,
  :content,
  :inquire,
  :categoried,
  :ways,
  :saler,
  :mechanics,
  :responses,
  :satisfaction,
  :customer,
  :response_principal
)

result = []
@complaint.order.items.each do |item|
  item.store_service_workflow_snapshots.each do |service_workflow|
    service_workflow.mechanics.each do |mechanic|
       result << {name: mechanic.full_name, id: mechanic.id }
    end
  end
end
json.order_mechanics result.uniq
