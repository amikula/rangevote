require File.dirname(__FILE__) + '/../../spec_helper'

describe "/polls/show.html.erb" do
  include PollsHelper
  
  before(:each) do
    @poll = mock_model(Poll)
    @poll.stub!(:name).and_return("MyString")
    @poll.stub!(:instructions).and_return("MyText")
    @poll.stub!(:results).and_return(nil)

    assigns[:poll] = @poll
  end

  it "should render attributes in <p>" do
    render "/polls/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

