require File.dirname(__FILE__) + '/../spec_helper'

describe PollsController do
  describe "handling GET /polls" do

    before(:each) do
      @poll = mock_model(Poll)
      Poll.stub!(:find).and_return([@poll])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all polls" do
      Poll.should_receive(:find).with(:all).and_return([@poll])
      do_get
    end
  
    it "should assign the found polls for the view" do
      do_get
      assigns[:polls].should == [@poll]
    end
  end

  describe "handling GET /polls.xml" do

    before(:each) do
      @poll = mock_model(Poll, :to_xml => "XML")
      Poll.stub!(:find).and_return(@poll)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all polls" do
      Poll.should_receive(:find).with(:all).and_return([@poll])
      do_get
    end
  
    it "should render the found polls as xml" do
      @poll.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /polls/1" do

    before(:each) do
      @poll = mock_model(Poll)
      Poll.stub!(:find).and_return(@poll)
    end
  
    def do_get
      get :show, :id => "1"
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
      Poll.should_receive(:find).with("1").and_return(@poll)
      do_get
    end
  
    it "should assign the found poll for the view" do
      do_get
      assigns[:poll].should equal(@poll)
    end
  end

  describe "handling GET /polls/1.xml" do

    before(:each) do
      @poll = mock_model(Poll, :to_xml => "XML")
      Poll.stub!(:find).and_return(@poll)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the poll requested" do
      Poll.should_receive(:find).with("1").and_return(@poll)
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

  describe "handling GET /polls/1/edit" do

    before(:each) do
      @poll = mock_model(Poll)
      Poll.stub!(:find).and_return(@poll)
    end
  
    def do_get
      get :edit, :id => "1"
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
      Poll.should_receive(:find).and_return(@poll)
      do_get
    end
  
    it "should assign the found Poll for the view" do
      do_get
      assigns[:poll].should equal(@poll)
    end
  end

  describe "handling POST /polls" do

    before(:each) do
      @poll = mock_model(Poll, :to_param => "1")
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

      it "should redirect to the new poll" do
        do_post
        response.should redirect_to(poll_url("1"))
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

  describe "handling PUT /polls/1" do

    before(:each) do
      @poll = mock_model(Poll, :to_param => "1")
      Poll.stub!(:find).and_return(@poll)
    end
    
    describe "with successful update" do

      def do_put
        @poll.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the poll requested" do
        Poll.should_receive(:find).with("1").and_return(@poll)
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
        response.should redirect_to(poll_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @poll.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /polls/1" do

    before(:each) do
      @poll = mock_model(Poll, :destroy => true)
      Poll.stub!(:find).and_return(@poll)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the poll requested" do
      Poll.should_receive(:find).with("1").and_return(@poll)
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