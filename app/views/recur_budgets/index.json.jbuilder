json.array!(@budgets) do |budget|
  json.extract! budget, :id, :title, :category, :price, :transaction_date
  json.url budget_url(budget, format: :json)
end
