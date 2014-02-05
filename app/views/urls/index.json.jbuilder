json.array!(@urls) do |url|
  json.extract! url, :id, :href, :alias, :views
  json.url url_url(url, format: :json)
end
