class LinksController < ApplicationController

  before_filter :authorize, :except => [:index, :show, :advanced_search]

  def advanced_search
    @groups = Group.all
    @years = ((Date.today.year - 20)..Date.today.year).to_a
  end

  def toggle_row_shading
    if session[:group_shading] == 'true'
      session[:group_shading] = 'false'
    else
      session[:group_shading] = 'true'
    end
    render nothing: true
  end


  def toggle_full_details
    if session[:full_details] == 'true'
      session[:full_details] = 'false'
    else
      session[:full_details] = 'true'
    end
    render nothing: true
  end

  def verify_link
    @link = Link.find(params[:id])
    if @link.valid_get?
      if @link.update_attribute(:verified_date, Time.now)
        render nothing: true, status: 200
      else
        render nothing: true, status: 422
      end
    else
      render nothing: true, status: 422
    end
  end

  def unverify_link
    @link = Link.find(params[:id])
    @link.verified_date = nil
    @link.save!
    respond_to do |format|
      format.js
    end
  end

  def index
    @from = PrepareSearch.start_date(params[:from] ||= '1991')
    @to = PrepareSearch.end_date(params[:to] ||= '2299')

    if params[:search_text_1st_phrase] # both simple and advanced search use this field.
      @words_1 = params[:search_text_1st_phrase]
      if params[:commit].downcase == 'advanced search'
        @join_operator = params[:join_operator].downcase
        @words_2 = params[:search_text_2nd_phrase]
        @text_search = PrepareSearch.text_search(@words_1, @join_operator, @words_2)
        @groups_comparison = PrepareSearch.groups(params[:groups])
        @version_information = { :version => params[:version].to_i, :version_comparison => params[:version_comparison], :include_blank_version => params[:include_blank_version] }
        @version_comparison = PrepareSearch.versions(@version_information)
        @date_comparison = PrepareSearch.dates(@from, @to)
        @conditions = '1=1' + @groups_comparison+ @date_comparison + @text_search
        # + @version_comparison
      else
        @conditions = PrepareSearch.basic_search(@words_1)
      end
    else
      @conditions = ''
    end
    @links = Link.where(@conditions).by_group_and_position
    respond_to do |format|
      format.html
    end
  end

  def show
    @link = Link.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def new
    @link = Link.new
    @link.content_date=Time.new().strftime("%m/%d/%Y")
    @link.url_address='http://'
    @groups = Group.all.collect { |g| [g.group_name, g.id] }
    @group_name =
      if params[:group_id]
        'for the '+Group.find(params[:group_id]).group_name + ' group.'
      else
        ''
      end
    respond_to do |format|
      format.html
    end
  end

  def edit
    @link = Link.find(params[:id])
    @link.content_date=Time.new().strftime("%m/%d/%Y") if @link.content_date.nil?
    @groups = Group.all.collect { |g| [g.group_name, g.id] }
    @group_name =
      if params[:group_id]
        'for the '+Group.find(params[:group_id]).group_name + ' group.'
      else
        ''
      end
    respond_to do |format|
      format.html
    end
  end

  def create
    @link = Link.new(link_params)

    if @link.content_date.nil?
      @link.content_date = Time.new().strftime("%Y/%m/%d")
    else
      @link.content_date = @link.content_date.strftime("%Y/%m/%d")
    end

    respond_to do |format|
      if @link.save
        unless @link.verified_date.nil?
          http_check_msg = 'and the url was verified as valid'
        else
          http_check_msg = 'however it was *not* possible to visit the url as given currently'
        end
        flash[:notice] = 'Link was successfully created, ' + http_check_msg
        format.html { redirect_to(@link) }
      else
        flash[:notice] = 'Error, The link was not created.'
        @groups = Group.all.collect { |g| [g.group_name, g.id] }
        format.html { render :action => "new"}
      end
    end
  end

  def update
    this_link = Link.find(params[:id])
    this_link.tap { |link| link.update!(link_params) }
    the_date = construct_date.to_date.strftime("%Y-%m-%d")
    this_link.update!(:content_date => the_date)
    redirect_to this_link
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.js
    end
  end

  private

  def construct_date
    link_params[:content_date][6,4]+'-'+link_params[:content_date][0,2]+'-'+link_params[:content_date][3,2]
  end

  def link_params
    params
    .require(:link)
    .permit(:url_address, :group_id, :alt_text, :version_number, :position, :content_date, :verified_date)
  end

end
