require File.dirname(__FILE__) + '/../spec_helper'

describe Vote do
  before(:each) do
    @vote = Vote.new
  end

  it "should be valid" do
    @vote.should be_valid
  end
end
