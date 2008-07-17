require File.dirname(__FILE__) + '/../spec_helper'

describe Poll do
  before(:each) do
    @poll = Poll.new
  end

  it "should be valid" do
    @poll.should be_valid
  end

  describe :results do
    it "shouldn't get an error if candidates have been added after voting started" do
      candidates = ["foo", "bar", "baz"]
      @poll.stub!(:candidates).and_return(candidates)

      vote = mock_model(Vote)
      vote.stub!(:ratings).and_return([1, 2])

      votes = [vote]
      votes.stub!(:count).and_return(1)
      @poll.stub!(:votes).and_return(votes)

      @poll.results
    end
  end
end
