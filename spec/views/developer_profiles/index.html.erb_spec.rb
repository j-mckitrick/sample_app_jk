require 'spec_helper'

describe "developer_profiles/index" do
  before(:each) do
    assign(:developer_profiles, [
      stub_model(DeveloperProfile,
        :user_id => 1,
        :employment => "Employment",
        :experience => "Experience",
        :yearly_projects => "Yearly Projects",
        :typical_project_size => "Typical Project Size",
        :how_did_you_hear => "How Did You Hear",
        :how_response => "How Response",
        :why => "Why",
        :state => "State"
      ),
      stub_model(DeveloperProfile,
        :user_id => 1,
        :employment => "Employment",
        :experience => "Experience",
        :yearly_projects => "Yearly Projects",
        :typical_project_size => "Typical Project Size",
        :how_did_you_hear => "How Did You Hear",
        :how_response => "How Response",
        :why => "Why",
        :state => "State"
      )
    ])
  end

  it "renders a list of developer_profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Employment".to_s, :count => 2
    assert_select "tr>td", :text => "Experience".to_s, :count => 2
    assert_select "tr>td", :text => "Yearly Projects".to_s, :count => 2
    assert_select "tr>td", :text => "Typical Project Size".to_s, :count => 2
    assert_select "tr>td", :text => "How Did You Hear".to_s, :count => 2
    assert_select "tr>td", :text => "How Response".to_s, :count => 2
    assert_select "tr>td", :text => "Why".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
