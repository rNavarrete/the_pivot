class AddOptionsToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :options, :text
  end
end
