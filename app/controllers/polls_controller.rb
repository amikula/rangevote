class PollsController < ApplicationController
  # GET /polls/1
  # GET /polls/1.xml
  def show
    @poll = Poll.find_by_key(params[:key])
    @title = @poll.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @poll }
    end
  end

  def admin
    @poll = Poll.find_by_admin_key(params[:key])
    @title = "Admin page for " + @poll.name

    respond_to do |format|
      format.html # admin.html.erb
      format.xml  { render :xml => @poll }
    end
  end

  # GET /polls/new
  # GET /polls/new.xml
  def new
    @poll = Poll.new
    @poll.poll_options = PollOptions.new
    @title = "Create a new poll"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @poll }
    end
  end

  # GET /polls/1/edit
  def edit
    @title = "Edit poll"
    @poll = Poll.find_by_admin_key(params[:key])
    @poll.poll_options ||= PollOptions.new
  end

  # POST /polls
  # POST /polls.xml
  def create
    @poll = Poll.new(params[:poll])
    @poll.poll_options ||= PollOptions.new
    @poll.poll_options.enable_captcha = params[:enable_captcha]

    @poll.candidates = posted_candidates


    @poll.initialize_keys

    respond_to do |format|
      if @poll.save
        flash[:notice] = 'Poll was successfully created.'
        format.html { redirect_to :action => :admin, :key => @poll.admin_key }
        format.xml  { render :xml => @poll, :status => :created, :location => @poll }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @poll.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /polls/1
  # PUT /polls/1.xml
  def update
    @poll = Poll.find_by_admin_key(params[:key])
    @poll.poll_options ||= PollOptions.new
    @poll.poll_options.enable_captcha = params[:enable_captcha]
    @poll.candidates = posted_candidates

    respond_to do |format|
      @poll.poll_options.save
      if @poll.update_attributes(params[:poll])
        flash[:notice] = 'Poll was successfully updated.'
        format.html { redirect_to(:action => :admin, :key => @poll.admin_key) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @poll.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.xml
  def destroy
    @poll = Poll.find_by_admin_key(params[:key])
    @poll.destroy

    respond_to do |format|
      format.html { redirect_to(polls_url) }
      format.xml  { head :ok }
    end
  end

  def delete_votes
    @poll = Poll.find_by_admin_key(params[:key])

    params[:vote].each do |vote_id|
      @poll.votes.find(vote_id).destroy
    end

    respond_to do |format|
      format.html { redirect_to :action => :admin, :key => @poll.admin_key }
      format.xml  { head :ok }
    end
  end

  def vote
    @poll = Poll.find_by_key(params[:key])
    @poll.poll_options ||= PollOptions.new
    @title = "Vote: " + @poll.name
    @vote = Vote.new
    @vote.ratings = ['X']*@poll.candidates.size

    respond_to do |format|
      format.html
      format.xml  { render :xml => @poll }
    end
  end

  def record_vote
    @poll = Poll.find_by_key(params[:key])
    ratings = []

    i = 0
    while this_vote = params["vote#{i}"]
      value = this_vote.to_i
      if params["no_opinion#{i}"] || value < 0 || value > 99
        ratings << "X"
      else
        ratings << this_vote.to_i
      end

      i += 1
    end

    @vote = Vote.new({:poll_id => @poll.id, :ratings => ratings, :name => params[:voter_name]})

    if(!@poll.poll_options.enable_captcha || verify_recaptcha(@vote))
      @vote.save!

      respond_to do |format|
        format.html { redirect_to :action => :show, :key => @poll.key }
        format.xml  { head :ok }
      end
    else
      respond_to do |format|
        format.html { render :action => :vote, :key => @poll.key }
        format.xml  { head :ok }
      end
    end
  end

  private
    def posted_candidates
      candidates = []
      i = 0
      while(candidate = params["candidate#{i}".to_sym])
        candidate.strip!
        candidates << candidate unless candidate.blank?
        i += 1
      end

      return candidates
    end
end
