class RenameNameToEmail < ActiveRecord::Migration
  def change
    rename_column :users, :name, :email_address
  end
end
