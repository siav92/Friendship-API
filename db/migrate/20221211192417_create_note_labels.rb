class CreateNoteLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :note_labels do |t|
      t.references :note, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end

    add_index :note_labels, %i[note_id label_id], unique: true
  end
end
