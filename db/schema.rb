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

ActiveRecord::Schema[7.0].define(version: 2025_01_06_023850) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "car_fuels", force: :cascade do |t|
    t.date "refueled_at"
    t.integer "odo"
    t.string "station"
    t.integer "price"
    t.text "footnote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "car_id", null: false
    t.integer "user_id", null: false
    t.boolean "admitted"
    t.float "unit_price"
    t.integer "fuel_type"
    t.index ["car_id"], name: "index_car_fuels_on_car_id"
    t.index ["user_id"], name: "index_car_fuels_on_user_id"
  end

  create_table "car_logs", force: :cascade do |t|
    t.date "at"
    t.integer "user_id", null: false
    t.integer "car_id", null: false
    t.integer "purpose"
    t.string "depart"
    t.string "arrive"
    t.integer "odo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_car_logs_on_car_id"
    t.index ["user_id"], name: "index_car_logs_on_user_id"
  end

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
    t.integer "user_id", null: false
    t.boolean "admitted"
    t.index ["car_id"], name: "index_car_repairs_on_car_id"
    t.index ["user_id"], name: "index_car_repairs_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "number"
    t.string "model"
    t.string "manufacturer"
    t.date "registered_at"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "insurance_start"
    t.date "insurance_end"
    t.integer "status"
    t.date "disposed_at"
    t.string "insurance_company"
    t.text "insurance_desc"
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

  create_table "meetings", force: :cascade do |t|
    t.date "at"
    t.text "description"
    t.integer "user_id", null: false
    t.string "title"
    t.text "footnote"
    t.string "is_exterior"
    t.string "attendee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admitted"
    t.index ["user_id"], name: "index_meetings_on_user_id"
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
    t.date "hire_date"
    t.string "position"
    t.integer "status"
    t.string "eid"
  end

  create_table "vacation_histories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "reason"
    t.boolean "is_approved"
    t.date "start_date"
    t.date "end_date"
    t.integer "vacation_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vacation_histories_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "car_logs", "cars"
  add_foreign_key "car_logs", "users"
  add_foreign_key "vacation_histories", "users"
end
