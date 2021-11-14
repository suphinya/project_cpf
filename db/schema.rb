# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_09_113309) do

  create_table "actuals", force: :cascade do |t|
    t.datetime "date"
    t.datetime "time_in"
    t.datetime "time_out"
    t.integer "OT"
    t.integer "user_id"
    t.integer "plan_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_actuals_on_plan_id"
    t.index ["user_id"], name: "index_actuals_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.datetime "date"
    t.datetime "time_in"
    t.datetime "time_out"
    t.integer "OT"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "name"
    t.string "surname"
    t.string "position"
    t.string "department1"
    t.string "department2"
    t.string "department3"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
