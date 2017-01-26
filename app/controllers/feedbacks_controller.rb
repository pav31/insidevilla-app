class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :set_estate, only: [:index, :create]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = @estate&.feedbacks || Feedback.all
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
    @maximum_length = Settings.feedback_length
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback =
      if @estate
        @estate.feedbacks.build(feedback_params)
      else
        @feedback = Feedback.new(feedback_params)
      end
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @estate, notice: t(:feedback_created) }
        format.json { render :show, status: :created, location: @feedback }
      else
        @feedback.photo.destroy
        flash[:alert] = @feedback.errors.full_messages
        format.json { render json: @feedback.errors.full_messages, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @estate, notice: t(:feedback_updated) }
        format.json { render :show, status: :ok, location: @feedback }
      else
        flash[:alert] = @feedback.errors.full_messages
        format.html { render :edit }
        format.json { render json: @feedback.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to @estate, notice: t(:feedback_destroyed) }
      format.json { head :no_content }
    end
  end

  private

  def set_estate
    @estate = Estate.find(params[:estate_id]) if params[:estate_id]
  end

  def set_feedback
    @feedback = Feedback.find(params[:id])
    @estate = @feedback.estate
  end

  def feedback_params
    params.require(:feedback).permit(:author, :email, :city, :occupation, :body, :photo, :estate_id, :approved, :favorite)
  end
end
