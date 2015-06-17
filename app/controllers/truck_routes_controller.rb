class TruckRoutesController < ApplicationController
  before_action :logged_in_user

  def new
    @truck_route = TruckRoute.new
  end
  def create
    @truck_route = TruckRoute.new(truck_route_params)
    if @truck_route.save
      flash[:success] = "Truck route added successfully."
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def truck_route_params
    params.require(:truck_route).permit(:name, :weekdays)
  end
end
