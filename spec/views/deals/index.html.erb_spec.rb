require 'spec_helper'

describe "deals/index" do
  before(:each) do
    assign(:deals, [
      stub_model(Deal,
        :user_id => 1,
        :followers_count => 2,
        :amount_to_raise => "9.99",
        :name => "Name",
        :state => "State",
        :description => "Description"
      ),
      stub_model(Deal,
        :user_id => 1,
        :followers_count => 2,
        :amount_to_raise => "9.99",
        :name => "Name",
        :state => "State",
        :description => "Description"
      )
    ])
  end

  it "renders a list of deals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
