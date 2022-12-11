# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_11_201511) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "friendship_status", ["inactive", "active", "unfriended", "rejected"]

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "status", default: "inactive", null: false, enum_type: "friendship_status"
    t.index ["status"], name: "index_friendships_on_status"
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
  end

  create_table "labels", force: :cascade do |t|
    t.string "title", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "to_tsvector('english_nostop'::regconfig, (title)::text)", name: "fts_index_labels_on_title", using: :gin
    t.index ["title"], name: "index_labels_on_title", unique: true
  end

  create_table "note_labels", force: :cascade do |t|
    t.bigint "note_id", null: false
    t.bigint "label_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_note_labels_on_label_id"
    t.index ["note_id", "label_id"], name: "index_note_labels_on_note_id_and_label_id", unique: true
    t.index ["note_id"], name: "index_note_labels_on_note_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "to_tsvector('english_nostop'::regconfig, (((title)::text || ' '::text) || content))", name: "fts_index_notes_on_title_and_content", using: :gin
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "to_tsvector('english_nostop'::regconfig, (name)::text)", name: "fts_index_users_on_name", using: :gin
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "friendships", "users", column: "friend_id", on_delete: :cascade
  add_foreign_key "friendships", "users", on_delete: :cascade
  add_foreign_key "note_labels", "labels"
  add_foreign_key "note_labels", "notes"
  add_foreign_key "notes", "users"
end
