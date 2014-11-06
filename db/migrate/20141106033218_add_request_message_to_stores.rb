class AddRequestMessageToStores < ActiveRecord::Migration
  def change
    add_column :stores, :request_message, :text
  end
end
