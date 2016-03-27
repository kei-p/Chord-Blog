class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.integer :author_id
      t.text :body

      t.timestamps null: false
    end
  end
end
