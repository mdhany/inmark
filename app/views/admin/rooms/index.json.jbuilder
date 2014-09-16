json.array!(@admin_rooms) do |admin_room|
  json.extract! admin_room, :id
  json.url admin_room_url(admin_room, format: :json)
end
