class AddOptionsToItems < ActiveRecord::Migration
    def up
      add_column :items, :clothing_options, :hstore
    end

  def down
    remove_column  :items, :clothing_options, :hstore
  end
end
