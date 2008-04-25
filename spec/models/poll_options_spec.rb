require File.dirname(__FILE__) + '/../spec_helper'

describe PollOptions do
  before(:each) do
    @poll_options = PollOptions.new
  end

  it "should be valid" do
    @poll_options.should be_valid
  end
end
