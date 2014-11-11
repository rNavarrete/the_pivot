class CreateStoreManagers < ActiveRecord::Migration
  def change
    create_table :store_managers do |t|
      t.references :user
      t.references :store

      t.timestamps
    end
  end
end
