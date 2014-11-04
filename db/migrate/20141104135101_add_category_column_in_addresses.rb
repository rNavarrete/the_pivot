class AddCategoryColumnInAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :category, :string
  end
end
