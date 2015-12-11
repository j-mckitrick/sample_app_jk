require 'test_helper'

class DealTest < ActiveSupport::TestCase
  default_address = {state: 'GA'}
  default_deal = {name: 'Great Deal',
                  address: Address.new(default_address),
                  short_description: 'desc',
                  amount_to_raise: 10000,
                  close_timeline: 'Dec 2014'}
  outside_ga_address = {state: 'FL'}
  outside_ga_deal = {name: 'Great Deal',
                     address: Address.new(outside_ga_address),
                     short_description: 'desc',
                     amount_to_raise: 10000,
                     close_timeline: 'Dec 2014'}

  test "cannot accept deals closing before oct 2014" do
    deal = Deal.new(default_deal)
    deal.close_timeline = 'Sept 2014'
    assert deal.invalid_deal?, 'Oh noes!  A Sept 2014 deal should be invalid!'
  end

  test "will accept deals closing after oct 2014" do
    deal = Deal.new(default_deal)
    deal.close_timeline = 'Dec 2014'
    assert_not deal.invalid_deal?, 'Oh noes!  An Oct 2014 deal should be valid!'
  end

  test "cannot accept deals over 200000" do
    deal = Deal.new(default_deal)
    deal.amount_to_raise = 200001
    assert deal.invalid_deal?, 'Oh noes!  A deal over $200000 should be invalid!'
  end

  test "will accept deals up to 200000" do
    deal = Deal.new(default_deal)
    deal.amount_to_raise = 200000
    assert_not deal.invalid_deal?, 'Oh noes!  A deal at $200000 should be valid!'
  end

  test "will accept deals under 200000" do
    deal = Deal.new(default_deal)
    deal.amount_to_raise = 199999
    assert_not deal.invalid_deal?, 'Oh noes!  A deal under $200000 should be valid!'
  end

  test "cannot accept deals outside GA" do
    deal = Deal.new(outside_ga_deal)
    assert deal.invalid_deal?, 'Oh noes!  A deal outside GA should be invalid!'
  end

  test "will accept deals within GA" do
    deal = Deal.new(default_deal)
    assert_not deal.invalid_deal?, 'Oh noes!  A deal in GA should be valid!'
  end
end
