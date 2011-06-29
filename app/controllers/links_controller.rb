class LinksController < ApplicationController

  before_filter :authorize, :except => [:index, :show]

  # GET /links
  # GET /links.xml
  def index
    @s = ""
    if params[:search_text]
      @s = params[:search_text]
      @links = Link.all(:joins => :group, :order => 'groups.group_name, links.position', :conditions =>
          ['url_address LIKE ? or alt_text LIKE ? or version_number LIKE ?',"%"+@s+"%", "%"+@s+"%", "%"+@s+"%"])
    else
      @links = Link.all(:joins => :group, :order => 'groups.group_name, links.position')
    end
    # ordering: group_id to group items by their group and position for the user ordering
    session[:row_shading] = (params[:row_shading] == 'true') ? 'true' : 'false' rescue 'false'
    session[:full_details] = (params[:full_details] == 'true') ? 'true' : 'false' rescue 'false'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new
    @groups = Group.find(:all, :order => 'group_name')

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
    @groups = Group.find(:all, :order => 'group_name')
  end

  # POST /links
  # POST /links.xml
  def create
    @link = Link.new(params[:link])

    respond_to do |format|
      if @link.save
        flash[:notice] = 'Link was successfully created.'
        format.html { redirect_to(@link) }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        @selected_group = params[:group_id]
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        flash[:notice] = 'Link was successfully updated.'
        format.html { redirect_to(@link) }
        format.xml  { head :ok }
      else
        @groups = Group.find(:all)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.xml  { head :ok }
    end
  end
end