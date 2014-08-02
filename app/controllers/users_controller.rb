class UsersController < ApplicationController

  before_filter :authorize

  def index
    @users = User.find(:all, :order => :username)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User '+ @user.username+ ' was successfully created.'
        format.html { redirect_to(:action => "index") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User '+ @user.username+ ' was successfully updated.'
        format.html { redirect_to(:action => "index") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    begin
      if @user.admin
        User.delete_one_admin(@user)
        flash[:notice] = "User #{@user.username} deleted"
      else
        if User.all.count > 1
          @user.destroy
          flash[:notice] = "User #{@user.username} deleted"
        else
          raise "You can't delete the only user!"
        end
      end
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

end
