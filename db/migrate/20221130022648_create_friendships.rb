class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, index: false, foreign_key: { on_delete: :cascade }
      t.references :friend, null: false, index: false, foreign_key: { to_table: :users, on_delete: :cascade }

      t.timestamps
    end

    add_index :friendships, %i[user_id friend_id], unique: true
  end
end
