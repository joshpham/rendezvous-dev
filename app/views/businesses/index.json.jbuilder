json.array!(@businesses) do |business|
  json.extract! business, :id, :name, :user_id, :business-name-slug
  json.url business_url(business, format: :json)
end


