class AddStoreIdToItems < ActiveRecord::Migration
  def change
    change_table :items do |t|
    	t.references :store, index: true
    end
  end
end
