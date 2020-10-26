class ItemsController < ApplicationController
  # ログインしていないユーザーはindex意外には遷移できず、ログイン画面に遷移する
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end
  private

  def item_params
    params.require(:item).permit(:image, :title, :explain, :category_id, :status_id, :charge_id, :area_id, :arrival_id, :price).merge(user_id: current_user.id)
  end
end
