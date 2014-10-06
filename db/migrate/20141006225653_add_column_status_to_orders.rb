class AddColumnStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :status, :string
  end
end
