class LinksController < ApplicationController

  before_filter :authorize, except: [:index, :show, :advanced_search]

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
      @link.update({verified_date: Time.now})
      respond_to do |format|
        format.html { render action: "show", flash[:notice] => 'Valid URL'}
        format.js { render nothing: true }
      end
    else
      respond_to do |format|
        format.html { render action: "show", flash[:alert] => 'invalid URL', status: 422}
        format.js { render nothing: true }
      end
    end
  end

  def unverify_link
    @link = Link.find(params[:id])
    @link.verified_date = nil
    @link.save!
    respond_to do |format|
      format.html { render action: "show"}
    end
  end

  def index
    if (FeatureSwitch.where(name: 'links_index_scrollable_table', status: 'on').count) > 0
      @thead_scroller = "thead_scroller"
      @tbody_scrolling = "tbody_scrolling"
    end
    @from = PrepareSearch.start_date(params[:from] ||= '1991')
    @to = PrepareSearch.end_date(params[:to] ||= '2299')

    if params[:search_text_1st_phrase] # both simple and advanced search use this field.
      @words_1 = params[:search_text_1st_phrase]
      if params[:commit].downcase == 'advanced search'
        @join_operator = params[:join_operator].downcase
        @words_2 = params[:search_text_2nd_phrase]
        @text_search = PrepareSearch.text_search(@words_1, @join_operator, @words_2)
        @groups_comparison = PrepareSearch.groups(params[:groups])
        @version_information = { version: params[:version].to_i, version_comparison: params[:version_comparison], include_blank_version: params[:include_blank_version] }
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
    #@links = Link.where(@conditions).by_group_and_position
    #@links = Link.includes(:group).where(@conditions).references(:group).order('groups.group_name, links.position')
    @links = Link.joins(:group).where(@conditions).references(:group).order('groups.group_name, links.position')
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
    # @link.content_date=Time.new().strftime("%m/%d/%Y")
    @link.content_date=Time.new().to_s[0,10]
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
    if @link.content_date.nil?
      @link.content_date=(Time.new().to_s)[0,10]
    end
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

    unless link_params[:content_date].nil?

      the_date = construct_date.to_date.strftime("%Y-%m-%d")
# %Y-%m-%d Date format required for date to save correctly AND tests not to fail !!! @link.content_date = Time.new().strftime("%Y/%m/%d") # %m/%d/%Y makes tests fail.
      @link.update!(content_date: the_date)

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
        format.html { render action: "new"}
      end
    end
  end

  def update
    this_link = Link.find(params[:id])
    this_link.update(link_params)
    this_link.tap { |link| link.update!(link_params) }
    the_date = construct_date #.to_date.strftime("%Y-%m-%d") # %Y-%m-%d Date format required for date to save correctly.
    this_link.update!(content_date: the_date)
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
    link_params[:content_date].to_s[6,4]+ '-' +
    link_params[:content_date].to_s[0,2]+ '-' +
    link_params[:content_date].to_s[3,2]
  end

  def link_params
    params
    .require(:link)
    .permit(:url_address, :group_id, :alt_text, :version_number, :position, :content_date, :verified_date)
  end

end
