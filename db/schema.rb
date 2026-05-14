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

ActiveRecord::Schema[8.1].define(version: 2026_05_12_003356) do
  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "nota", null: false
    t.bigint "quadra_id", null: false
    t.text "texto", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["quadra_id"], name: "index_comments_on_quadra_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "quadras", force: :cascade do |t|
    t.string "cidade", null: false
    t.datetime "created_at", null: false
    t.text "descricao"
    t.string "endereco", null: false
    t.string "foto_url"
    t.string "nome", null: false
    t.boolean "tem_iluminacao", default: false
    t.string "tipo_piso"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "nome", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "quadras"
  add_foreign_key "comments", "users"
end
