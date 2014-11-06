class AddOnlineToStores < ActiveRecord::Migration
  def change
    add_column :stores, :online, :boolean, :default => true
  end
end
