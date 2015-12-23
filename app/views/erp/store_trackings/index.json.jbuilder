json.array! @trackings do |tracking|
  json.created_at tracking.created_at.strftime('%Y-%m-%d')
  json.property 'xx'
  json.numero tracking.store_order.try(:numero) || '无关联信息'
  json.contact_way tracking.contact_way
  json.executant tracking.automatic ? '系统' : tracking.executant
  json.content tracking.content
end
