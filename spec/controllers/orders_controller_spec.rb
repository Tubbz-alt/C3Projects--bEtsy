require 'rails_helper'
require 'pry'

RSpec.describe OrdersController, type: :controller do

  describe "GET #index" do

    it "renders the :index view for a User's orders" do
       get :index
       expect(response).to render_template("index")
    end

    it "loads all orders into @orders" do
      order, order2 = Order.create(id: 1), Order.create(id:2)
      item, item2 = OrderItem.create(quantity: 1, order_id: 1, product_id: 1), OrderItem.create(quantity: 1, order_id: 2, product_id: 1)
      get :index
      expect(assigns(:orders)).to match_array([order, order2])
    end
  end

  # describe "GET #new" do
  #   it "saves a new blank instance of an order in a variable" do
  #     @order = Order.new(id: 5)
  #     @order.save
  #     get :new
  #     expect(Order.count).to eq 1
  #   end
  # end

  describe "GET #show " do
    before(:each) do
      @order = Order.create(id: 1)
      @item = OrderItem.create(quantity: 1, order_id: 1, product_id: 1)
      session[:order_id] = @order.id
    end

    after :each do
      @order.destroy
    end

    it "allows vendors to see their orders" do
      get :show, id: @order.id, order_id: @item.order_id
      expect(assigns(:order)).to eq(@order)
    end
  end


  describe "PATCH #update" do
    before(:each) do
      @product = Product.create(name: 'Doll', price: 10, user_id: 1, status: 'active')
      @order = Order.create(status: "pending")
      @item = OrderItem.create(quantity: 1, order_id: @order.id, product_id: @product.id)
      session[:order_id] = @order.id
    end

    after :each do
      @order.destroy
    end

    it "changes the order status to 'paid'" do
      patch :update, :id => @order.id, checkout: {status: "paid"}
      @order.reload
      expect(@order.status).to eq("paid")
    end

    it "resets the session to nil when a transaction is complete" do
      patch :update, :id => @order.id, checkout: {status: "paid"}
      expect(session[:order_id]).to eq(nil)
    end

  end


end
