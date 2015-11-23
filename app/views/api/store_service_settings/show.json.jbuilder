json.(@setting, :id, :setting_type)
if @setting.setting_type == 0 && @setting.workflow
  json.partial! 'workflow'
else
  json.partial! 'workflows'
end
