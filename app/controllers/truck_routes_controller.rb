class TruckRoutesController < ApplicationController
  before_action :logged_in_user

  def index
    @truck_route = TruckRoute.new
    @truck_routes = TruckRoute.order(:name)
  end
  def new
    @truck_route = TruckRoute.new
  end
  def create
    @truck_route = TruckRoute.new(truck_route_params)
    if @truck_route.save
      flash[:success] = "Truck route added successfully."
      redirect_to truck_routes_path
    else
      render 'new'
    end
  end
  def edit
    @truck_route = TruckRoute.find(params[:id])
  end
  def update
    @truck_route = TruckRoute.find(params[:id])
    if @truck_route.update(truck_route_params)
      flash[:success] = "Truck route updated successfully."
      redirect_to truck_routes_path 
    else
      render 'edit'
    end
  end
  def destroy
    truck_route = TruckRoute.find(params[:id])
    income_records = truck_route.incomes.count
    if income_records > 0
      flash[:error] = "This Truck route has #{income_records} assigned incomes. You cannot remove it."
      redirect_to truck_routes_path
    else 
      truck_route.destroy
      flash[:success] = "Truck route removed successfully."
      redirect_to truck_routes_path
    end 
  end

  private

  def truck_route_params
    params.require(:truck_route).permit(:name, :weekdays)
  end
end
