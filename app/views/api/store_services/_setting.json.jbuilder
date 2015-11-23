if @service.setting.setting_type == 0
  json.setting do
    json.id @service.setting.id
    json.setting_type @service.setting_type
    json.partial! 'workflow' if @service.setting.workflow
    json.partial! 'workflows'
  end
else
  json.setting do
    json.id @service.setting.id
    json.setting_type @service.setting_type
    json.partial! 'workflows'
  end
end
