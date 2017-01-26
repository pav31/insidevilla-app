class WelcomeController < ApplicationController
  before_action :set_slider, only: :index

  def index
    @q = Estate.ransack(params[:q])
    @estates = @q.result(distinct: true).featured(7)

    @estates_first = @estates[0..1]
    @estates_second = @estates[2..4]
    @estates_third = @estates[5..6]
    @feedbacks = Feedback.landing_page
    session.delete(:q)
  end

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end

  def set_slider
    @slider = Slider.active
    gon.slider = {}.tap do |slider|
      @slider.each { |slide| slider[slide.id] = slide.image.url(:large) }
    end
  end
end
