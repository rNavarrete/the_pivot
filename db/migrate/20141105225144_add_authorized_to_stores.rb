class AddAuthorizedToStores < ActiveRecord::Migration
  def change
    add_column :stores, :authorized, :boolean, :default => false
  end
end
