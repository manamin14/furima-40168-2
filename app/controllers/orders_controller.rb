class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end
  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city_name, :street_address, :building_name, :phone_number, :order_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
