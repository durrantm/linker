class LinksController < ApplicationController

  before_filter :authorize, :except => [:index, :show, :advanced_search]

  def advanced_search  # This is the search form
    @groups = Group.all
    @years = ((Date.today.year - 20)..Date.today.year).to_a
  end

  # GET /links
  def index
    @from = params[:from]? ('01/01/'+params[:from]).to_date : '01/01/1991'.to_date
    @to = params[:to]? params[:to]+'/12/31' : '2099/12/31' 
    if params[:search_text_1st_phrase]
      @srch = params[:search_text_1st_phrase]
      if params[:search_text_2nd_phrase] # Implies an advanced search
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

        @srch_2 = params[:search_text_2nd_phrase]
        @version = (params[:version].to_f)
        @version_comparison = '(version_number ' + params[:version_comparison] + ' ' + @version.to_s
        if params[:include_blank_version]  # If not checked doesn't pass.'
          @version_comparison+= " or version_number is NULL or version_number = '' )"
        else
          @version_comparison+= " and version_number is not NULL and version_number <> '' )"
        end
        @date_comparison = ' and ((content_date is NULL) or (content_date > ' + @from.to_s + '))'
        @join_operator = params[:join_operator].downcase

       # @conditions = construct_advanced_search_string(params[:groups], @srch, @srch2, params[:version].to_f, params[:version_comparison], params[:include_blank_version], @from, @date_comparison, @join_operator)
      else
        @conditions = ['(url_address LIKE ? or alt_text LIKE ? or version_number LIKE ?)', "%"+@srch+"%", "%"+@srch+"%", "%"+@srch+"%"]
      end
    else
      @conditions = ''
    end
    @links = Link.all(:joins => :group, :include => :group, :order => 'groups.group_name, links.position', :conditions => @conditions)
    session[:full_details] = (params[:full_details] == 'true') ? 'true' : 'false' rescue 'false'
    respond_to do |format|
      format.html # index.html.erb
    end
  end

# make private ! Also Make a new object for this!
  def construct_advanced_search_string(groups, srch, srch2, version, version_comparison, include_blank_version, from, date_comparison, join_operator)
    # TODO wip
  end


  # GET /links/1
  def show
    @link = Link.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /links/new
  def new
    @link = Link.new
    @groups = Group.find(:all, :order => 'group_name')
    @group_name = 
      if params[:group_id]
        'for the '+Group.find(params[:group_id]).group_name + ' group.'
      else
        ''
      end
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
    @groups = Group.find(:all, :order => 'group_name')
    @group_name = 
      if params[:group_id]
        'for the '+Group.find(params[:group_id]).group_name + ' group.'
      else
        ''
      end
  end

  # POST /links
  def create
    @link = Link.new(params[:link])

    respond_to do |format|
      if @link.save
        flash[:notice] = 'Link was successfully created.'
        format.html { redirect_to(@link) }
      else
        format.html { render :action => "new"}
      end
    end
  end

  # PUT /links/1
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        flash[:notice] = 'Link was successfully updated.'
        format.html { redirect_to(@link.group) }
      else
        @groups = Group.find(:all)
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /links/1
  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    respond_to do |format|
      format.html { redirect_to(links_url) }
    end
  end
end
