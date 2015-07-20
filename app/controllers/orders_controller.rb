class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def checkout
    @order = Order.find(session[:order_id])
    @order_items = @order.order_items
  end

  def finalize
    @order = Order.find(session[:order_id])
    @order.update(order_params)
    if @order.save
      redirect_to confirmation_path
    else
      flash.now[:errors] = "Please fill in every field to complete your order."
      render :checkout
    end
  end

  def confirmation
  end

  private

  # do I need this here? will need it for :update, not for :create
  def order_params
    params.require(:order).permit(:status, :email, :cc_name, :cc_number, 
      :cc_expiration, :cc_cvv, :billing_zip, :shipped, :address1, :address2,
      :city, :state, :mailing_zip)
  end
end
