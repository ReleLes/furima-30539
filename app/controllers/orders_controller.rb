class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find, only: [:index, :create]

  def index
    if @item.order || current_user.id == @item.user_id
      redirect_to root_path
    end
    @form_objects = FormObjects.new
  end

  def create
    @form_objects = FormObjects.new(order_params)
    if @form_objects.valid?
      pay_item
      @form_objects.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def item_find
    @item = Item.find(params[:item_id])
  end
  
  def order_params
    params.require(:form_objects).permit(
      :postal_code, :prefectures_id, :municipalities, :address, :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token], price: @item.price)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(amount: order_params[:price], card: order_params[:token], currency: 'jpy')
  end
end
