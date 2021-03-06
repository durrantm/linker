# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  before_filter :authorize, except: :login # Whitelisting method - best approach.

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery with: :exception # :secret => '2874469e964c91d355de8f5289b6c348'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password
protected
  def authorize
    unless User.find_by({id: session[:user_id]})
      if request.get? && !request.xhr?
        session[:original_uri] = request.url
      end
      flash[:notice] = "Please Log In!"
      redirect_to controller: 'ladmin', action: 'login'
    end
  end

  def authorize_admin
    if session[:user_id] && User.find(session[:user_id]).admin
      true
    else
      flash[:warning] = 'You are not authorized for that function'
      redirect_to links_path
    end
  end

end
