require File.dirname(__FILE__) + '/../../spec_helper'

describe "/polls/new.html.erb" do
  include PollsHelper
  
  before(:each) do
    @poll = mock_model(Poll)
    @poll.stub!(:new_record?).and_return(true)
    @poll.stub!(:name).and_return("MyString")
    @poll.stub!(:instructions).and_return("MyText")
    @poll.stub!(:admin_key).and_return("abc")
    @poll.stub!(:poll_options).and_return(PollOptions.new)
    @poll.stub!(:candidates).and_return([])
    assigns[:poll] = @poll
  end

  it "should render new form" do
    render "/polls/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", "/polls/create/abc") do
      with_tag("input#poll_name[name=?]", "poll[name]")
      with_tag("textarea#poll_instructions[name=?]", "poll[instructions]")
    end
  end
end


