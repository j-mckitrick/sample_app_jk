# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deal do
    user_id 1
    state "MyString"
    capital_type "MyString"
    close_timeline "MyString"
    name "MyString"
    short_description "MyString"
    amount_to_raise ""
    followers_count 1
  end
end
