# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    addressable_type "MyString"
    addressable_id 1
    name "MyString"
    address1 "MyString"
    address2 "MyString"
    city "MyString"
    state "MyString"
    zipcode "MyString"
  end
end
