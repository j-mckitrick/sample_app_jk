class HomeController < ApplicationController
  def index
  end

  def next_steps
  end

  def investments
    @published_offers = Deal.all
  end

  def developers
  end
end
