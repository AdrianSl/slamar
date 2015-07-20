class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in_user
    redirect_to new_user_session_path unless user_signed_in?
  end

  def date_to_url(date)
    I18n.l date.to_date, format: :url_date
  end

  def from_date(date)
    if !date.blank?
      date
    else
      I18n.l (Time.now - 1.month), format: :url_date
    end
  end

  def to_date(date)
    if !date.blank?
      date
    else
      I18n.l Time.now, format: :url_date
    end
  end
end
