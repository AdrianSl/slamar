class BrandShopsController < ApplicationController
  before_action :logged_in_user
  def index
    @brand_shop = BrandShop.new
    @brand_shops = BrandShop.order(:name)
  end

  def new
    @brand_shop = BrandShop.new
  end

  def create
    @brand_shop = BrandShop.new(brand_shop_params)
    if @brand_shop.save
      flash[:success] = 'Brand shop added successfully.'
      redirect_to brand_shops_path
    else
      render 'new'
    end
  end

  def edit
    @brand_shop = BrandShop.find(params[:id])
  end

  def update
    @brand_shop = BrandShop.find(params[:id])
    if @brand_shop.update(brand_shop_params)
      flash[:success] = 'Brand shop updated successfully.'
      redirect_to brand_shops_path
    else
      render 'edit'
    end
  end

  def destroy
    brand_shop = BrandShop.find(params[:id])
    income_records = brand_shop.incomes
    if income_records.present?
      flash[:error] = 'This Brand shop has assigned incomes. You cannot remove it.'
      redirect_to brand_shops_path
    else
      brand_shop.destroy
      flash[:success] = 'Brand shop removed successfully.'
      redirect_to brand_shops_path
    end
  end

  private

  def brand_shop_params
    params.require(:brand_shop).permit(:name)
  end
end
