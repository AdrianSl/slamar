class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_user
  include DashboardHelper

  def index
    today = date_to_url(DateTime.now)
    redirect_to dashboard_path(today)
  end

  def show
    @presenter = DashboardPresenter.new(params[:id])
  end

  def create
    if workday_created?(params[:date])
      flash[:error] = 'Workday already exists.'
    else
      create_workday_elements(params[:date])
      flash[:success] = 'New workday created successfully.'
    end
    redirect_to dashboard_path(date_to_url(params[:date]))
  end

  private

  def create_workday_elements(day)
    truck_routes = TruckRoute.weekday(day.to_date.wday)
    brand_shops = BrandShop.all
    external_shops = ExternalShop.daily_payments
    data = [truck_routes, brand_shops, external_shops]
    data.each do |item|
      item.each do |shop|
        shop.incomes.create(date: day)
      end
    end
  end
end
