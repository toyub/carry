json.array! @trackings do |tracking|
  json.(tracking, :contact_way, :content)
  json.created_at tracking.created_at.strftime('%Y-%m-%d')
  json.property tracking.property
  json.numero tracking.store_order.try(:numero) || '无关联信息'
  json.executant tracking.automatic ? '系统' : tracking.executant
end
