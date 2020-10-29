class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @form_objects = FormObjects.new
    @item = Item.find(params[:format])
  end

  def create
    @form_objects = FormObjects.new(order_params)
    if @form_objects.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:form_objects).permit(
      :postal_code, :prefectures_id, :municipalities, :address, :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
