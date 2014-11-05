class AddOptionsColumnToItem < ActiveRecord::Migration
  def up
    add_column :items, :options, :hstore
  end

  def down
    remove_column :items, :options
  end
end
