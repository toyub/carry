json.array! @staffers do |staffer|
  json.id staffer.id
  json.screen_name staffer.screen_name
  json.department staffer.store_department.try(:name)
  json.position staffer.store_position.try(:name)
  json.roles staffer.roles
end
