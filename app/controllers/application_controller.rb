class ApplicationController < ActionController::Base
  include Jpmobile::ViewSelector

  before_action :mobile?
  protect_from_forgery with: :null_session
  helper_method :current_user, :logged_in?
  before_action :set_locale

  if Rails.env.production?
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from Exception, with: :render_500
  end

  rescue_from PsException::ValidationError do |e|
    flash[:alert] = e.messages
    redirect_to :back
  end

  def mobile?
    if request.smart_phone?
      jpn = Company.pluck(:name)
      us = UsCompany.pluck(:name)
      gon.mobile_company_names = [jpn, us].flatten
    end
  end

  def logged_in?
    current_user != nil
  end

  def current_user
    @current_user ||= session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def set_locale
    I18n.locale = session[:lang] if session[:lang].present?
    I18n.locale, session[:lang] = params[:lang].to_sym, params[:lang].to_sym if params[:lang].present?
  end

  def render_404(exception = nil)
    if exception
      Rails.logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render template: 'errors/error_404', status: 404, layout: 'application'
  end

  def render_500(exception = nil)
    if exception
      Rails.logger.info "Rendering 500 with exception: #{exception.message}"
    end
    render template: 'errors/error_500', status: 500, layout: 'application'
  end
end
