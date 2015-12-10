# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :developer_profile do
    user_id 1
    employment "MyString"
    experience "MyString"
    yearly_projects "MyString"
    typical_project_size "MyString"
    how_did_you_hear "MyString"
    how_response "MyString"
    why "MyString"
    state "MyString"
  end
end
