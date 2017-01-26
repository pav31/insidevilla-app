json.array!(@comforts) do |comfort|
  json.extract! comfort, :id
  json.url comfort_url(comfort, format: :json)
end
