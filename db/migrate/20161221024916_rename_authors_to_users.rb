class RenameAuthorsToUsers < ActiveRecord::Migration
  def change
  	rename_table :authors, :users
    rename_column :entries, :author_id, :user_id
  end
end
