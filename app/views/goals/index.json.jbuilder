json.array!(@goals) do |goal|
  json.extract! goal, :id, :goal, :amount, :maturity_time
  json.url goal_url(goal, format: :json)
end
