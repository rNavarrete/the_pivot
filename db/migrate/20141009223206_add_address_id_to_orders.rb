class AddAddressIdToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
    t.references :address, index: true
    end
  end
end
