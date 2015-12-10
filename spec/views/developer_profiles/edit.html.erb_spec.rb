require 'spec_helper'

describe "developer_profiles/edit" do
  before(:each) do
    @developer_profile = assign(:developer_profile, stub_model(DeveloperProfile,
      :user_id => 1,
      :employment => "MyString",
      :experience => "MyString",
      :yearly_projects => "MyString",
      :typical_project_size => "MyString",
      :how_did_you_hear => "MyString",
      :how_response => "MyString",
      :why => "MyString",
      :state => "MyString"
    ))
  end

  it "renders the edit developer_profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", developer_profile_path(@developer_profile), "post" do
      assert_select "input#developer_profile_user_id[name=?]", "developer_profile[user_id]"
      assert_select "input#developer_profile_employment[name=?]", "developer_profile[employment]"
      assert_select "input#developer_profile_experience[name=?]", "developer_profile[experience]"
      assert_select "input#developer_profile_yearly_projects[name=?]", "developer_profile[yearly_projects]"
      assert_select "input#developer_profile_typical_project_size[name=?]", "developer_profile[typical_project_size]"
      assert_select "input#developer_profile_how_did_you_hear[name=?]", "developer_profile[how_did_you_hear]"
      assert_select "input#developer_profile_how_response[name=?]", "developer_profile[how_response]"
      assert_select "input#developer_profile_why[name=?]", "developer_profile[why]"
      assert_select "input#developer_profile_state[name=?]", "developer_profile[state]"
    end
  end
end
