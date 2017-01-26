class ComfortsController < ApplicationController
  before_action :set_comfort, only: [:show, :edit, :update, :destroy]

  # GET /comforts
  # GET /comforts.json
  def index
    @comforts = Comfort.all
  end

  # GET /comforts/1
  # GET /comforts/1.json
  def show
  end

  # GET /comforts/new
  def new
    @comfort = Comfort.new
  end

  # GET /comforts/1/edit
  def edit
  end

  # POST /comforts
  # POST /comforts.json
  def create
    @comfort = Comfort.new(comfort_params)

    respond_to do |format|
      if @comfort.save
        format.html { redirect_to @comfort, notice: 'Comfort was successfully created.' }
        format.json { render :show, status: :created, location: @comfort }
      else
        format.html { render :new }
        format.json { render json: @comfort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comforts/1
  # PATCH/PUT /comforts/1.json
  def update
    respond_to do |format|
      if @comfort.update(comfort_params)
        format.html { redirect_to @comfort, notice: 'Comfort was successfully updated.' }
        format.json { render :show, status: :ok, location: @comfort }
      else
        format.html { render :edit }
        format.json { render json: @comfort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comforts/1
  # DELETE /comforts/1.json
  def destroy
    @comfort.destroy
    respond_to do |format|
      format.html { redirect_to comforts_url, notice: 'Comfort was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render layout: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comfort
      @comfort = Comfort.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comfort_params
      params.require(:comfort).permit(:name, :category, :icon)
    end
end
