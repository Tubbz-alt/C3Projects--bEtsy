class OrderItemsController < ApplicationController


  def index
    @order_items = OrderItem.joins(:order).where('orders.status' => 'pending').where('orders.id' => session[:order_id])
  end

  def new
    @item = OrderItem.new
    @product = Product.find(params[:product_id])
    @merchant = Product.find(params[:product_id]).user_id
    @stock = @product.stock
    if @stock == 0
      flash.now[:error] = "We're Sorry, This Item is Currently Sold Out!"
    end
  end

  def create

    increase_by = params[:order_item][:quantity].to_i
    existing_cart = session[:order_id]
    current_product_id = params[:order_item][:product_id]
    current_order_item = OrderItem.where(product_id: current_product_id , order_id: existing_cart)

    if current_order_item.present?
      raise "extra carts found" if current_order_item.count > 1
      @item = current_order_item.first
      @item.quantity += increase_by

    else
      @item = OrderItem.create(create_params[:order_item])
    
    end
    # If we don't have an order_id in the session, create one
    unless session[:order_id]
      new_order
    end

    # Update the item with the order_id
    @item.order_id = session[:order_id]
    @item.save

    redirect_to cart_path
  end

  def edit
    @order_item = OrderItem.find(params[:id])
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(create_params[:order_item])

    redirect_to dashboard_orders_path
  end

  def destroy
    @item = OrderItem.find(params[:id])
    @item.destroy


    redirect_to cart_path
  end

  private

  def create_params
    params.permit(order_item: [:quantity, :order_id, :product_id, :user_id, :shipping])
  end

end
