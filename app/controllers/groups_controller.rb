class GroupsController < ApplicationController

  before_filter :authorize, :except => [:index, :show]

  def index
    @groups = Group.find(:all, :order => 'group_name')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  def show
    @group = Group.find(params[:id])
    @members = Link.find_all_by_group_id(params[:id], :order => 'position')
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  def order_links
    params[:urlys].each_with_index do |id, index|
      Link.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  def new
    @group = Group.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(params[:group])
    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(@group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.links.count == 0
        if @group.destroy
          flash[:notice] = 'Group was successfully deleted.'
          format.html { redirect_to(groups_url) }
          format.xml  { head :ok }
        else
          flash[:notice] = 'Error deleting group, not deleted.'
          format.html { redirect_to(groups_url) }
          format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
        end
      else
        flash[:notice] = 'Error deleting group because it is not empty.'
        format.html { redirect_to(groups_url) }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end
end
