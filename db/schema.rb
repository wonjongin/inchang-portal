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

ActiveRecord::Schema[7.0].define(version: 2023_10_06_031058) do
  create_table "car_repairs", force: :cascade do |t|
    t.date "repaired_at"
    t.integer "odo"
    t.string "center"
    t.text "desc"
    t.integer "price"
    t.text "footnote"
    t.integer "car_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_car_repairs_on_car_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "number"
    t.string "model"
    t.string "manufacturer"
    t.date "registered_at"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cashios", force: :cascade do |t|
    t.date "date", null: false
    t.integer "io"
    t.string "account"
    t.text "desc"
    t.text "note"
    t.integer "price", null: false
    t.boolean "is_base_balance"
    t.boolean "admitted"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cashios_on_user_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.date "date"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admitted"
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "desc"
    t.integer "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_events_on_diary_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "desc"
    t.integer "user_id", null: false
    t.integer "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_feedbacks_on_diary_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.string "icon"
    t.boolean "read"
    t.integer "about"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "pw"
    t.string "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
