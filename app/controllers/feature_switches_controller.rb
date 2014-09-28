class FeatureSwitchesController < ApplicationController
  before_action :set_feature_switch, only: [:show, :edit, :update, :destroy]

  # GET /feature_switches
  def index
    @feature_switches = FeatureSwitch.all
  end

  # GET /feature_switches/1
  def show
  end

  # GET /feature_switches/new
  def new
    @feature_switch = FeatureSwitch.new
  end

  # GET /feature_switches/1/edit
  def edit
  end

  # POST /feature_switches
  def create
    @feature_switch = FeatureSwitch.new(feature_switch_params)

    if @feature_switch.save
      redirect_to @feature_switch, notice: 'Feature switch was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /feature_switches/1
  def update
    if @feature_switch.update(feature_switch_params)
      redirect_to @feature_switch, notice: 'Feature switch was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /feature_switches/1
  def destroy
    @feature_switch.destroy
    redirect_to feature_switches_url, notice: 'Feature switch was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature_switch
      @feature_switch = FeatureSwitch.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feature_switch_params
      params.require(:feature_switch).permit(:status, :name, :description, :conditions)
    end
end
