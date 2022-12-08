class AddStatusToFriendship < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE friendship_status AS ENUM ('inactive', 'active', 'unfriended', 'rejected');
    SQL

    add_column(:friendships, :status, :friendship_status, default: :inactive, null: false)

    add_index :friendships, %i[status]
  end

  def down
    # Also drops the column and index via cascade
    execute <<-SQL
      DROP Type friendship_status cascade;
    SQL
  end
end
