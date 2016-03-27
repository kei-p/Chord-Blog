json.array!(@entries) do |entry|
  json.extract! entry, :id, :title, :author_id, :body
  json.url entry_url(entry, format: :json)
end
