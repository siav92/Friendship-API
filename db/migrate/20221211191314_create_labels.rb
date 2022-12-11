class CreateLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :labels do |t|
      t.string :title, null: false
      t.string :color, null: false

      t.timestamps
    end

    add_index :labels, :title, unique: true
  end
end
