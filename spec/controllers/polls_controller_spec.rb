require File.dirname(__FILE__) + '/../spec_helper'

describe PollsController do
  describe "handling GET /polls/abc" do

    before(:each) do
      @poll = mock_model(Poll, :name => "Mock Poll")
      Poll.stub!(:find_by_key).and_return(@poll)
    end
  
    def do_get
      get :show, :key => "abc"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the poll requested" do
      Poll.should_receive(:find_by_key).with("abc").and_return(@poll)
      do_get
    end
  
    it "should assign the found poll for the view" do
      do_get
      assigns[:poll].should equal(@poll)
    end
  end

  describe "handling GET /polls/abc.xml" do

    before(:each) do
      @poll = mock_model(Poll, :to_xml => "XML", :name => "Mock Poll")
      Poll.stub!(:find_by_key).and_return(@poll)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :key => "abc"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the poll requested" do
      Poll.should_receive(:find_by_key).with("abc").and_return(@poll)
      do_get
    end
  
    it "should render the found poll as xml" do
      @poll.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /polls/new" do

    before(:each) do
      @poll = mock_model(Poll)
      @poll.stub!(:poll_options=)
      Poll.stub!(:new).and_return(@poll)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new poll" do
      Poll.should_receive(:new).and_return(@poll)
      do_get
    end
  
    it "should not save the new poll" do
      @poll.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new poll for the view" do
      do_get
      assigns[:poll].should equal(@poll)
    end
  end

  describe "handling GET /polls/abc/edit" do

    before(:each) do
      @poll = mock_model(Poll)
      @poll.stub!(:poll_options)
      @poll.stub!(:poll_options=)
      Poll.stub!(:find_by_admin_key).and_return(@poll)
    end
  
    def do_get
      get :edit, :key => "abc"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the poll requested" do
      Poll.should_receive(:find_by_admin_key).and_return(@poll)
      do_get
    end
  
    it "should assign the found Poll for the view" do
      do_get
      assigns[:poll].should equal(@poll)
    end
  end

  describe "handling POST /polls" do

    before(:each) do
      @poll = mock_model(Poll, :to_param => "abc")
      @poll.stub!(:poll_options).and_return(PollOptions.new)
      @poll.stub!(:candidates=)
      @poll.stub!(:initialize_keys)
      @poll.stub!(:admin_key).and_return("abc")
      Poll.stub!(:new).and_return(@poll)
    end
    
    describe "with successful save" do
  
      def do_post
        @poll.should_receive(:save).and_return(true)
        post :create, :poll => {}
      end
  
      it "should create a new poll" do
        Poll.should_receive(:new).with({}).and_return(@poll)
        do_post
      end

      it "should redirect to admin page for the new poll" do
        do_post
        response.should redirect_to(:action => :admin, :key => "abc")
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @poll.should_receive(:save).and_return(false)
        post :create, :poll => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /polls/abc" do

    before(:each) do
      @poll = mock_model(Poll, :admin_key => "abc")
      @poll.stub!(:poll_options).and_return(PollOptions.new)
      @poll.stub!(:candidates=)
      Poll.stub!(:find_by_admin_key).and_return(@poll)
    end
    
    describe "with successful update" do

      def do_put
        @poll.should_receive(:update_attributes).and_return(true)
        put :update, :key => "abc"
      end

      it "should find the poll requested" do
        Poll.should_receive(:find_by_admin_key).with("abc").and_return(@poll)
        do_put
      end

      it "should update the found poll" do
        do_put
        assigns(:poll).should equal(@poll)
      end

      it "should assign the found poll for the view" do
        do_put
        assigns(:poll).should equal(@poll)
      end

      it "should redirect to the poll" do
        do_put
        response.should redirect_to(:action => :admin, :key => "abc")
      end

    end
    
    describe "with failed update" do

      def do_put
        @poll.should_receive(:update_attributes).and_return(false)
        put :update, :key => "abc"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /polls/abc" do

    before(:each) do
      @poll = mock_model(Poll, :destroy => true)
      Poll.stub!(:find_by_admin_key).and_return(@poll)
    end
  
    def do_delete
      delete :destroy, :key => "abc"
    end

    it "should find the poll requested" do
      Poll.should_receive(:find_by_admin_key).with("abc").and_return(@poll)
      do_delete
    end
  
    it "should call destroy on the found poll" do
      @poll.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the polls list" do
      do_delete
      response.should redirect_to(polls_url)
    end
  end
end
