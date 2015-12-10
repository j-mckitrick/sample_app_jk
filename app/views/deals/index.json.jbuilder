json.array!(@deals) do |deal|
  json.extract! deal, :id, :user_id, :capital_type, :close_timeline, :amount_to_raise, :name, :state, :short_description, :amount_to_raise
  json.url deal_url(deal, format: :json)
end
