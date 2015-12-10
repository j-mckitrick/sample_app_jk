require 'spec_helper'

describe "deals/show" do
  before(:each) do
    @deal = assign(:deal, stub_model(Deal,
      :user_id => 1,
      :followers_count => 2,
      :amount_to_raise => "9.99",
      :name => "Name",
      :state => "State",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/9.99/)
    rendered.should match(/Name/)
    rendered.should match(/State/)
    rendered.should match(/Description/)
  end
end
