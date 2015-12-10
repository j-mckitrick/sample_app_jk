require 'spec_helper'

describe "developer_profiles/show" do
  before(:each) do
    @developer_profile = assign(:developer_profile, stub_model(DeveloperProfile,
      :user_id => 1,
      :employment => "Employment",
      :experience => "Experience",
      :yearly_projects => "Yearly Projects",
      :typical_project_size => "Typical Project Size",
      :how_did_you_hear => "How Did You Hear",
      :how_response => "How Response",
      :why => "Why",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Employment/)
    rendered.should match(/Experience/)
    rendered.should match(/Yearly Projects/)
    rendered.should match(/Typical Project Size/)
    rendered.should match(/How Did You Hear/)
    rendered.should match(/How Response/)
    rendered.should match(/Why/)
    rendered.should match(/State/)
  end
end
