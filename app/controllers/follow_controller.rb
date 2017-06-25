class FollowController < ApplicationController
  def follow_deal
    puts "Params #{params}"
    @follow = Follow.new(:user_id => current_user.id, :deal_id => params[:deal_id])
    @follow.save
    puts "Params #{@follow.inspect}"
    render :json => {:success => true}
  end
end
