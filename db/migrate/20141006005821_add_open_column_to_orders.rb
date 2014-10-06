class AddOpenColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :open, :boolean
  end
end
