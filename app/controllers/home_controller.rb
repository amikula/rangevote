class HomeController < ApplicationController
  def index
    # display index.html
  end

  def show
    render :action => params[:page]
  end
end
