json.array!(@messages) do |message|
  json.extract! message, :id, :message, :sent_on, :phone_list_id
  json.url message_url(message, format: :json)
end
