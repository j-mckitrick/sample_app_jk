json.array!(@developer_profiles) do |developer_profile|
  json.extract! developer_profile, :id, :user_id, :employment, :experience, :yearly_projects, :typical_project_size, :how_did_you_hear, :how_response, :why, :state
  json.url developer_profile_url(developer_profile, format: :json)
end
