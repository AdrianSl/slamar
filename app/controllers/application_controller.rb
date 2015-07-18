class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in_user
    redirect_to new_user_session_path unless user_signed_in?
  end

  def date_to_url(date)
    date.to_date.strftime('%Y-%m-%d')
  end

  def from_date(date)
    if !date.blank?
      date
    else
      (Time.now - 1.month).strftime('%Y-%m-%d')
    end
  end

  def to_date(date)
    if !date.blank?
      date
    else
      Time.now.strftime('%Y-%m-%d')
    end
  end
end
