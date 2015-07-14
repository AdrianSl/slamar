class ExternalShopsController < ApplicationController
  before_action :logged_in_user

  def index
    @external_shop = ExternalShop.new
    @external_shops = ExternalShop.order(:name)
  end
  def new
    @external_shop = ExternalShop.new
  end
  def create
    @external_shop = ExternalShop.new(external_shop_params)
    if @external_shop.save
      flash[:success] = "External shop added successfully."
      redirect_to external_shops_path
    else
      render 'new'
    end
  end
  def edit
    @external_shop = ExternalShop.find(params[:id])
  end
  def update
    @external_shop = ExternalShop.find(params[:id])
    if @external_shop.update(external_shop_params)
      flash[:success] = "External shop updated successfully."
      redirect_to external_shops_path 
    else
      render 'edit'
    end
  end
  def destroy
    external_shop = ExternalShop.find(params[:id])
    income_records = external_shop.incomes
    if income_records.present?
      flash[:error] = "This External shop has assigned incomes. You cannot remove it."
      redirect_to external_shops_path
    else 
      external_shop.destroy
      flash[:success] = "External shop removed successfully."
      redirect_to external_shops_path
    end 
  end

  private

  def external_shop_params
    params.require(:external_shop).permit(:name, :daily_payments)
  end
end
