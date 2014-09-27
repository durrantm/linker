class GroupsController < ApplicationController

  before_filter :authorize, except: [:index, :show]

  def index
    @groups = Group.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @groups }
    end
  end

  def show
    @group = Group.find(params[:id])
    @members = Link.where(group_id: params[:id]).order(:position)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render xml: @group }
      format.json { render json: @members } # for ajax to show link members before deleting group.
    end
  end

  def order_links
    params[:link].each_with_index do |id, index|
      Link.where(id: id).update_all(['position = ?',index+1])
    end
    render nothing: true
  end

  def new
    @group = Group.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @group }
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
        format.xml  { render xml: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.xml  { render xml: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    redirect_to Group.find(params[:id]).tap { |group|
      group.update!(group_params)
    }

  end

  def destroy
    @group = Group.find(params[:id])
    respond_to do |format|
      group_link_count= @group.links.count
      if @group.destroy
        flash[:notice] = "Group " + ((group_link_count > 0) ? "(and #{group_link_count} member links) " : "") + "was deleted"
        format.html { redirect_to(groups_url) }
        format.xml  { head :ok }
      else
        flash[:notice] = 'Error deleting group, not deleted.'
        format.html { redirect_to(groups_url) }
        format.xml  { render xml: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def group_params
    params.require(:group).permit(:group_name, :group_description)
  end

end
