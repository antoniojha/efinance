json.array!(@spendings) do |spending|
  json.extract! spending, :id, :title, :description, :image_url, :price, :transaction_date
  json.url spending_url(spending, format: :json)
end
