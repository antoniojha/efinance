json.array!(@temp_items) do |temp_item|
  json.extract! temp_item, :id
  json.url temp_item_url(temp_item, format: :json)
end
