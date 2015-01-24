json.array!(@suggesteds) do |suggested|
  json.extract! suggested, :id, :name
  json.url suggested_url(suggested, format: :json)
end
