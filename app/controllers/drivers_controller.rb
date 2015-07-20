class DriversController < ApplicationController
  before_action :logged_in_user

  def index
    @driver = Driver.new
    @drivers = Driver.list
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      flash[:success] = 'Driver added successfully.'
      redirect_to drivers_path
    else
      render 'new'
    end
  end

  def edit
    @driver = Driver.find(params[:id])
  end

  def update
    @driver = Driver.find(params[:id])
    if @driver.update(driver_params)
      flash[:success] = 'Driver updated successfully.'
      redirect_to drivers_path
    else
      render 'edit'
    end
  end

  def destroy
    driver = Driver.find(params[:id])
    income_records = driver.incomes
    if income_records.present?
      flash[:error] = 'This Driver has assigned incomes. You cannot remove it.'
      redirect_to drivers_path
    else
      driver.destroy
      flash[:success] = 'Driver removed successfully.'
      redirect_to drivers_path
    end
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :surname)
  end
end
