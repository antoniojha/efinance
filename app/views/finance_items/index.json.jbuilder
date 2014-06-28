json.array!(@finance_items) do |finance_item|
  json.extract! finance_item, :id, :goal_id, :temp_item_id
  json.url finance_item_url(finance_item, format: :json)
end
