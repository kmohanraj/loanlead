# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_31_174259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.string "society"
    t.string "block"
    t.string "flat_number"
    t.string "product_feedback"
    t.string "executive_feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "housing_rentals", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.string "society_name"
    t.string "block"
    t.string "flat_no"
    t.string "bedroom"
    t.string "square_feet"
    t.string "rental_amt"
    t.string "deposit"
    t.string "negotiable"
    t.string "site_visit"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.string "name"
    t.string "contact_no"
    t.string "email"
    t.string "loan_amount"
    t.integer "status"
    t.string "profession"
    t.float "salary"
    t.string "remarks"
    t.string "obligation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "reference"
  end

  create_table "references", force: :cascade do |t|
    t.string "contact_no"
    t.bigint "feedback_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feedback_id"], name: "index_references_on_feedback_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "references", "feedbacks"
end
