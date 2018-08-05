class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :micropost_id
  end
end
