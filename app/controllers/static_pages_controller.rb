class StaticPagesController < ApplicationController
  SHOW_CATEGORIES = %i[info service about]

  def index
    @static_pages = StaticPage.all
  end

  def show
    if params[:id].to_sym.in? SHOW_CATEGORIES
      @static_pages = StaticPage.public_send(params[:id])
      render :show_pages
    else
      @static_page = StaticPage.with_locale(I18n.locale).friendly.find(params[:id])
    end
  end
end
