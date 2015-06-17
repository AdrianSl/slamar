class ExternalShopsController < ApplicationController
  before_action :logged_in_user

  def new
    @external_shop = ExternalShop.new
  end
  def create
    @external_shop = ExternalShop.new(external_shop_params)
    if @external_shop.save
      flash[:success] = "External shop added successfully."
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def external_shop_params
    params.require(:external_shop).permit(:name, :daily_payments)
  end
end
