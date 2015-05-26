class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_user

  def index
  end
end
