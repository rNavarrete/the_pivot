class AddStoreIdToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
    	t.references :store, index: true
    end
  end
end
