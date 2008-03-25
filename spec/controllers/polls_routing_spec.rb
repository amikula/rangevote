require File.dirname(__FILE__) + '/../spec_helper'

describe PollsController do
  describe "route generation" do

    it "should map { :controller => 'polls', :action => 'index' } to /polls" do
      route_for(:controller => "polls", :action => "index").should == "/polls"
    end
  
    it "should map { :controller => 'polls', :action => 'new' } to /polls/new" do
      route_for(:controller => "polls", :action => "new").should == "/polls/new"
    end
  
    it "should map { :controller => 'polls', :action => 'show', :id => 1 } to /polls/1" do
      route_for(:controller => "polls", :action => "show", :id => 1).should == "/polls/1"
    end
  
    it "should map { :controller => 'polls', :action => 'edit', :id => 1 } to /polls/1/edit" do
      route_for(:controller => "polls", :action => "edit", :id => 1).should == "/polls/1/edit"
    end
  
    it "should map { :controller => 'polls', :action => 'update', :id => 1} to /polls/1" do
      route_for(:controller => "polls", :action => "update", :id => 1).should == "/polls/1"
    end
  
    it "should map { :controller => 'polls', :action => 'destroy', :id => 1} to /polls/1" do
      route_for(:controller => "polls", :action => "destroy", :id => 1).should == "/polls/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'polls', action => 'index' } from GET /polls" do
      params_from(:get, "/polls").should == {:controller => "polls", :action => "index"}
    end
  
    it "should generate params { :controller => 'polls', action => 'new' } from GET /polls/new" do
      params_from(:get, "/polls/new").should == {:controller => "polls", :action => "new"}
    end
  
    it "should generate params { :controller => 'polls', action => 'create' } from POST /polls" do
      params_from(:post, "/polls").should == {:controller => "polls", :action => "create"}
    end
  
    it "should generate params { :controller => 'polls', action => 'show', id => '1' } from GET /polls/1" do
      params_from(:get, "/polls/1").should == {:controller => "polls", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'polls', action => 'edit', id => '1' } from GET /polls/1;edit" do
      params_from(:get, "/polls/1/edit").should == {:controller => "polls", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'polls', action => 'update', id => '1' } from PUT /polls/1" do
      params_from(:put, "/polls/1").should == {:controller => "polls", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'polls', action => 'destroy', id => '1' } from DELETE /polls/1" do
      params_from(:delete, "/polls/1").should == {:controller => "polls", :action => "destroy", :id => "1"}
    end
  end
end