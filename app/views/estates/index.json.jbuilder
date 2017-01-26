json.array!(@estates) do |estate|
  json.extract! estate, :id, :title, :status, :type, :featured, :latitude, :longitude, :area_size
  json.url estate_url(estate, format: :json)
end
