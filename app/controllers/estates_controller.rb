class EstatesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :search, :reset_filter]
  before_action :set_estate, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /estates
  # GET /estates.json
  def index
    if id = params[:id]
      @estate = Estate.find_by_id(id)
      redirect_to @estate if @estate
    end

    @all_comforts = Comfort.all

    session[:price_period] ||= 'month'
    session[:price_period] = params[:price_period] if params[:price_period]
    to_remove = session[:price_period] == 'day' ? 'month' : 'day'
    if session[:q]
      session[:q].delete("price_#{to_remove}_low_cents_gteq_price")
      session[:q].delete("price_#{to_remove}_low_cents_lteq_price")
    end

    # Set params[:q] tenure_type (rent/sale) with value that came from navigation link
    if params[:tenure_type].present?
      params[:q] = { tenure_type_eq: params[:tenure_type] }
    end

    if params[:q].present?
      # COPY session filtered keys to params[:q]
      filtered = filtering_params(params[:q])
      session.update(q: filtered)
    else
      session[:q]&.symbolize_keys!
      params[:q] = session[:q] ||= {}
    end

    set_prices

    @q = Estate.ransack(params[:q])
    @estates =
      if params[:q]&.has_key?(:estate_comforts_comfort_id_eq_any)
        comforts_count = params[:q][:estate_comforts_comfort_id_eq_any].count
        ids = @q.result.includes(:estate_comforts).group_by(&:id).select { |k, v| v.count == comforts_count}.keys
        Estate.where(id: ids)
      else
        @q.result(distinct: true)
      end.order(sort_column + ' ' + sort_direction).page(params[:page])
  end

  # GET /estates/1
  # GET /estates/1.json
  def show
    @feedbacks = @estate&.feedbacks.approved.limit(6)
    @similar = @estate.similar
    @bookings = @estate.bookings
    gon.slider_url = @estate.slider(:large)
    lat = @estate.lat || @estate.latitude || Settings.latitude
    long = @estate.long || @estate.longitude || Settings.longitude
    gon.lat = lat + Settings.map_offset
    gon.lng = long + Settings.map_offset
  end

  # GET /estates/new
  def new
    @estate = Estate.new
  end

  # GET /estates/1/edit
  def edit
  end

  # POST /estates
  # POST /estates.json
  def create
    @estate = Estate.new(estate_params)

    respond_to do |format|
      if @estate.save
        if params[:image]
          @image = @estate.images.create(image_params)
        end
        format.html { redirect_to @estate, notice: t(:estate_created) }
        format.json { render :show, status: :created, location: @estate }
      else
        format.html { render :new }
        format.json { render json: @estate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estates/1
  # PATCH/PUT /estates/1.json
  def update
    respond_to do |format|
      if @estate.update(estate_params)
        if params[:image]
          @image = @estate.images.create(image_params)
        end
        format.html { redirect_to @estate, notice: t(:estate_updated) }
        format.json { render :show, status: :ok, location: @estate }
        format.js { render :update }
      else
        format.html { render :edit }
        format.json { render json: @estate.errors, status: :unprocessable_entity }
        format.js { render :update }
      end
    end
  end

  # DELETE /estates/1
  # DELETE /estates/1.json
  def destroy
    @estate.destroy
    respond_to do |format|
      format.html { redirect_to estates_url, notice: t(:estate_destroyed) }
      format.json { head :no_content }
    end
  end

  def search
    # index
    # render :index unless params[:id]
  end

  def reset_filter
    session.delete(:q)
    session.delete(:price_period)
    redirect_to estates_path
  end

  private

  def set_estate
    @estate = Estate.find_by_id(params[:id])
  end

  def set_prices
    gon.from_price_day = session[:q]&.symbolize_keys[:price_day_low_cents_gteq_price] || gon.min_range_day
    gon.upto_price_day = session[:q]&.symbolize_keys[:price_day_low_cents_lteq_price] || gon.max_range_day
    gon.from_price_month = session[:q]&.symbolize_keys[:price_month_low_cents_gteq_price] || gon.min_range_month
    gon.upto_price_month = session[:q]&.symbolize_keys[:price_month_low_cents_lteq_price] || gon.max_range_month
  end

  def estate_attributes
    %i[
      place region
      title address description area_size bedrooms bathrooms sea_distance estate_type tenure_type featured available draft
      slider main_image lat long airport_distance we_manage
      price
      price_day_low
      price_day_high
      price_day_pick
      price_week_low
      price_week_high
      price_week_pick
      price_month_low
      price_month_high
      price_month_pick
      admin_price
      admin_price_day_low
      admin_price_day_high
      admin_price_day_pick
      admin_price_week_low
      admin_price_week_high
      admin_price_week_pick
      admin_price_month_low
      admin_price_month_high
      admin_price_month_pick
      commission_long_term
      commission_short_term
    ]
 end

  def image_attributes
    %i[attachment name]
  end

  def feedback_attributes
    %i[estate author email city occupation body photo active]
  end

  def filter_attributes
    %i[
      tenure_type_eq
      place_eq
      region_eq
      estate_type_eq
      bathrooms_eq
      bedrooms_eq
      sea_distance_eq
      price_day_low_cents_gteq_price
      price_day_low_cents_lteq_price
      price_month_low_cents_gteq_price
      price_month_low_cents_lteq_price
      estate_comforts_comfort_id_eq_any
    ]
  end

  def estate_params
    params.require(:estate).permit(*estate_attributes,
                                   image_attributes: image_attributes,
                                   feedback_attributes: feedback_attributes)
  end

  def image_params
    params.require(:image).permit(*image_attributes)
  end

  def filtering_params(search_params)
    search_params.symbolize_keys.slice(*filter_attributes)
  end

  def sort_column
    Estate.column_names.include?(params[:sort]) ? params[:sort] : "price_month_low_cents"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
