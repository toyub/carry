json.staff do
  json.(@staff,
    :id,
    :store_id,
    :position,
    :department,
    :user_name,
    :name,
    :cash_auth,
    :store_name,
    :photo)
end
json.info @status.notice
