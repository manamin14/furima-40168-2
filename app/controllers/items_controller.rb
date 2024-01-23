class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_to_index, except: [:index, :show]
  before_action :set_tweet, only: [:edit, :update]
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to item_path
  end

  def move_to_index
    item = Item.find_by(id: params[:id])
    unless item && user_signed_in? && item.user_id == current_user.id
      redirect_to action: :index
    end
  end
  

  private

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :detail_id, :shipping_detail_id, :shipping_day_id, :prefecture_id, :price, :image).merge( user_id: current_user.id )
  end
end