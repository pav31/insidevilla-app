class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale,
                :load_static_pages,
                :set_best_offers,
                :set_options_for_collections,
                :set_contact_form,
                :set_ranges

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def load_static_pages
    @static_pages = StaticPage.with_locale(I18n.locale)
                              .order(:category)
                              .group_by(&:category)
  end

  def set_contact_form
    @contact = Contact.new
  end

  def set_best_offers
    @estate_best_offers = Estate.featured(3)
  end

  def set_options_for_collections
    @tenure_collection = Estate.tenure_types.map { |key, _| [I18n.t("tenure_types.#{key}"), key] }
    @place_collection = Estate.places.map { |key, _| [I18n.t("places.#{key}"), key] }
    @region_collection = Estate.regions.map { |key, _| [I18n.t("estate_regions.#{key}"), key] }
    @type_collection = Estate.estate_types.map { |key, _| [I18n.t("estate_types.#{key}"), key] }
    @bathrooms_collection = Estate.pluck(:bathrooms).uniq.sort
    @bedrooms_collection = Estate.pluck(:bedrooms).uniq.sort
    @distance_collection = I18n.t(:sea_distances).map(&:reverse)
  end

  def set_ranges
    gon.min_range_month = Estate.minimum(:price_month_low_cents)&.send(:/, 100)
    gon.max_range_month = Estate.maximum(:price_month_low_cents)&.send(:/, 100)
    gon.min_range_day = Estate.minimum(:price_day_low_cents)&.send(:/, 100)
    gon.max_range_day = Estate.maximum(:price_day_low_cents)&.send(:/, 100)
  end

  protected

  def redirect_to_back(params)
    redirect_to :back, params
  rescue ActionController::RedirectBackError
    redirect_to root_path, params
  end
end
