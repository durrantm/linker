class LadminController < ApplicationController
  def login
    session[:user_id] = nil
  	if request.post?
  	  user = User.authenticate(params[:username], params[:password])
  	  if user
        session[:user_id] = user.id
        session[:username] = user.username
        session[:admin] = user.admin
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || {:action => "index", :controller => :links})
  	  else
    		flash.now[:notice] = "Invalid username/password combination"
  	  end
  	end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    session[:admin] = nil
    flash[:notice] = "Logged Out"
    redirect_to(:action => "index", :controller => :links)
  end

  def index
  end

end
