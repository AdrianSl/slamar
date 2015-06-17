class DriversController < ApplicationController
  before_action :logged_in_user

  def new
    @driver = Driver.new
  end
  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      flash[:success] = "Driver added successfully."
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :surname)
  end
end
