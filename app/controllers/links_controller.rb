class LinksController < ApplicationController

  before_filter :authorize, :except => [:index, :show, :advanced_search]

  def advanced_search  # This is the search form
    @groups = Group.all
    @years = ((Date.today.year - 20)..Date.today.year).to_a
  end

  # GET /links
  # GET /links.xml
  def index
#    @s = ""
#    @now=DateTime.now
    @from = params[:from]? ('01/01/'+params[:from]).to_date : '01/01/1991'.to_date
    @to = params[:to]? ('31/12/'+params[:to]).to_date : ('31/12/' + DateTime.now.year.to_s).to_date
    if params[:search_text_1]
      @srch = params[:search_text_1]
      if params[:search_text_2] # An advanced search
        #
        # groups...
        @groups_comparison = ' and group_id in (-1'
        if params[:groups]
          params[:groups].each do |group_id|
            @groups_comparison+= ','+group_id
          end
          @groups_comparison+= ')'
        end
        #
        @srch_2 = params[:search_text_2] # May be null
        @version = (params[:version].is_a?(Integer))? params[:version].to_i : 0 # May be 0
        @version_comparison = '(version_number ' + params[:version_comparison] + ' ' + @version.to_s + ' or version_number is NULL) '
        case params[:join_operator].downcase
          when /and/
            @conditions =
              [@version_comparison + @groups_comparison + ' and ((content_date >= ? and content_date <= ?) or content_date is NULL) and ' +
              '(url_address LIKE ? or alt_text LIKE ?) and (url_address LIKE ? or alt_text LIKE ?)',
              @from, @to, "%"+@srch+"%", "%"+@srch+"%", "%"+@srch_2+"%", "%"+@srch_2+"%"]
          when /or/
            @conditions =
              [@version_comparison + @groups_comparison +  ' and ((content_date >= ? and content_date <= ?) or content_date is NULL) and ' +
              '((url_address LIKE ? or alt_text LIKE ?) or (url_address LIKE ? or alt_text LIKE ?))',
               @from, @to, "%"+@srch+"%", "%"+@srch+"%", "%"+@srch_2+"%", "%"+@srch_2+"%"]
        end
      else # Just a simple search
        @conditions = ['(url_address LIKE ? or alt_text LIKE ? or version_number LIKE ?)', "%"+@srch+"%", "%"+@srch+"%", "%"+@srch+"%"]
      end
    else
      @conditions = ''
    end
    @links = Link.all(:joins => :group, :order => 'groups.group_name, links.position', :conditions => @conditions)

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