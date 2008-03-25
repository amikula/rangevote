require File.dirname(__FILE__) + '/../../spec_helper'

describe "/polls/edit.html.erb" do
  include PollsHelper
  
  before do
    @poll = mock_model(Poll)
    @poll.stub!(:name).and_return("MyString")
    @poll.stub!(:instructions).and_return("MyText")
    assigns[:poll] = @poll
  end

  it "should render edit form" do
    render "/polls/edit.html.erb"
    
    response.should have_tag("form[action=#{poll_path(@poll)}][method=post]") do
      with_tag('input#poll_name[name=?]', "poll[name]")
      with_tag('textarea#poll_instructions[name=?]', "poll[instructions]")
    end
  end
end


