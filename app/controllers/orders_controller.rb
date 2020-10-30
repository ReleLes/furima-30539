class OrdersController < ApplicationController

  def index
    item_find
    if user_signed_in? && @item.order || user_signed_in? && (current_user.id == @item.user_id)
      redirect_to root_path
    elsif user_signed_in?
      @form_objects = FormObjects.new
    else
      redirect_to user_session_path
    end
  end

  def create
    item_find
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
    @item = Item.find(params[:format])
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
