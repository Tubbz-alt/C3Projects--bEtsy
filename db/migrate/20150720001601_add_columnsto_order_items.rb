class AddColumnstoOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :unit_price, :decimal, precision: 12, scale: 2
    add_column :order_items, :total_price, :decimal, precision: 12, scale: 2
    add_column :order_items, :status, :string
  end
end
