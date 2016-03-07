json.(@service, :id, :introduction, :remark, :category, :category_id, :category_name)
json.uploads @service.uploads, :file_url
json.reminds @service.reminds, :id, :content, :mode, :delay_interval, :enable, :notice_required, :trigger_timing, :store_service_id
json.trackings @service.trackings, :id, :content, :mode, :delay_interval, :delay_unit, :notice_required, :trigger_timing, :store_service_id
json.store_materials @service.store_materials, :id, :name, :root_category, :category
json.partial! 'setting'
