class SettingsController < ApplicationController
  def change_locale
    request_referer = URI(request.referer).path
    regexp = request_referer == '/' ? '/' : /\A\/((ru)|(en))/
    request_referer.gsub!(regexp, "/#{params[:locale]}")
    redirect_to request_referer
  end

  def reset
    Settings.destroy_all
    redirect_to :back
  end
end