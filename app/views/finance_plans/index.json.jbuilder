json.array!(@finance_plans) do |finance_plan|
  json.extract! finance_plan, :id, :description
  json.url finance_plan_url(finance_plan, format: :json)
end
