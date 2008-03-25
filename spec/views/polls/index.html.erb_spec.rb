require File.dirname(__FILE__) + '/../../spec_helper'

describe "/polls/index.html.erb" do
  include PollsHelper
  
  before(:each) do
    poll_98 = mock_model(Poll)
    poll_98.should_receive(:name).and_return("MyString")
    poll_98.should_receive(:instructions).and_return("MyText")
    poll_99 = mock_model(Poll)
    poll_99.should_receive(:name).and_return("MyString")
    poll_99.should_receive(:instructions).and_return("MyText")

    assigns[:polls] = [poll_98, poll_99]
  end

  it "should render list of polls" do
    render "/polls/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

