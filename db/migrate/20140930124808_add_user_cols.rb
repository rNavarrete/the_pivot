class AddUserCols < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :screen_name, :string
  end
end
