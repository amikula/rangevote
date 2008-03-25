require File.dirname(__FILE__) + '/../spec_helper'

describe Poll do
  before(:each) do
    @poll = Poll.new
  end

  it "should be valid" do
    @poll.should be_valid
  end
end
