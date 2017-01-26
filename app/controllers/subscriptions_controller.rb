class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:unsubscribe, :destroy]

  def create
    email = params.require(:subscription)[:email]
    @subscription = Subscription.new(email: email, token: SecureRandom.hex(10).to_s, active: true)
    email_exists = Subscription.exists?(["lower(email) = ?", email&.downcase])
    msg = if @subscription.save || email_exists
      InfoMailer.subscribed(@subscription.id).deliver_later unless email_exists
      { notice: t(:subscription_created) }
    else
      { alert: t('errors.message.invalid') }
    end
    redirect_to_back msg
  end

  def unsubscribe
    @static = StaticPage.find_by_slug('unsubscribe')
    @subs_token = params[:del]
    unless @subscription.eq_token? @subs_token
      redirect_to root_url
    end
  end

  def destroy
    if @subscription.eq_token? params[:del]
      @subscription.destroy
      flash[:notice] = t(:subscription_destroyed)
    end
    redirect_to root_path
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  private

  def subscription_params
    params.require(:subscription).permit(:email, :token, :active)
  end
end
