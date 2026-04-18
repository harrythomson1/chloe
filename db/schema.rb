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

ActiveRecord::Schema[8.1].define(version: 2026_04_18_091851) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "condition_symptoms", force: :cascade do |t|
    t.bigint "condition_id", null: false
    t.datetime "created_at", null: false
    t.bigint "symptom_id", null: false
    t.datetime "updated_at", null: false
    t.index ["condition_id"], name: "index_condition_symptoms_on_condition_id"
    t.index ["symptom_id"], name: "index_condition_symptoms_on_symptom_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.string "slug"
    t.string "source_url"
    t.datetime "updated_at", null: false
  end

  create_table "medications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.string "rx_norm_id"
    t.string "slug"
    t.datetime "updated_at", null: false
  end

  create_table "symptoms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", null: false
  end

  create_table "user_conditions", force: :cascade do |t|
    t.bigint "condition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["condition_id"], name: "index_user_conditions_on_condition_id"
    t.index ["user_id"], name: "index_user_conditions_on_user_id"
  end

  create_table "user_medications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "dosage"
    t.string "frequency"
    t.bigint "medication_id", null: false
    t.text "notes"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["medication_id"], name: "index_user_medications_on_medication_id"
    t.index ["user_id"], name: "index_user_medications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "condition_symptoms", "conditions"
  add_foreign_key "condition_symptoms", "symptoms"
  add_foreign_key "user_conditions", "conditions"
  add_foreign_key "user_conditions", "users"
  add_foreign_key "user_medications", "medications"
  add_foreign_key "user_medications", "users"
end
