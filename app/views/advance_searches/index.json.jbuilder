json.array!(@advance_searches) do |advance_search|
  json.extract! advance_search, :id, :keyword, :start_date, :end_date, :minimum_price, :maximum_price
  json.url advance_search_url(advance_search, format: :json)
end
