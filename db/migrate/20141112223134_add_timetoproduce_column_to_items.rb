class AddTimetoproduceColumnToItems < ActiveRecord::Migration
  def change
    add_column :items, :timetoproduce, :integer, default: 5
  end
end
