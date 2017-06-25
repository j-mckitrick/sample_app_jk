require 'test_helper'

class FollowsControllerTest < ActionController::TestCase
  setup do
    @user = User.new()
    @deal = Deal.new()
  end

  test "should create follow" do
    post :create, follow: {
    assert_difference('Follow.count') do
      post :create, deal: { amount_to_raise: @deal.amount_to_raise, description: @deal.description, followers_count: @deal.followers_count, state: @deal.state, user_id: @deal.user_id }
    end

    assert_redirected_to deal_path(assigns(:deal))
  end
end
