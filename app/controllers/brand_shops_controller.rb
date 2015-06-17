class BrandShopsController < ApplicationController
  before_action :logged_in_user

  def new
    @brand_shop = BrandShop.new
  end
  def create
    @brand_shop = BrandShop.new(brand_shop_params)
    if @brand_shop.save
      flash[:success] = "Brand shop added successfully."
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def brand_shop_params
    params.require(:brand_shop).permit(:name)
  end
end
