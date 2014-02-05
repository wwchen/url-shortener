json.array!(@urls) do |url|
  json.extract! url, :id, :original, :compressed, :views
  json.url url_url(url, format: :json)
end
