class UpdateOpenColumnOnOrders < ActiveRecord::Migration
  def change
    change_column :orders, :status, :boolean, default: true
  end
end
