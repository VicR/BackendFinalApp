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

ActiveRecord::Schema.define(version: 20180514022203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "characteristics", force: :cascade do |t|
    t.string "field"
    t.string "value"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_characteristics_on_product_id"
  end

  create_table "client_printers", force: :cascade do |t|
    t.datetime "adquisition_date"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_printers_on_client_id"
  end

  create_table "client_services", force: :cascade do |t|
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.decimal "total"
    t.index ["client_id"], name: "index_client_services_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fabricators", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "employee_qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "high_tech_products", force: :cascade do |t|
    t.string "country"
    t.date "fabrication_date"
    t.bigint "product_id"
    t.bigint "fabricator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fabricator_id"], name: "index_high_tech_products_on_fabricator_id"
    t.index ["product_id"], name: "index_high_tech_products_on_product_id"
  end

  create_table "product_adquisitions", force: :cascade do |t|
    t.datetime "adquisition_date"
    t.integer "quantity"
    t.bigint "product_id"
    t.bigint "provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_adquisitions_on_product_id"
    t.index ["provider_id"], name: "index_product_adquisitions_on_provider_id"
  end

  create_table "product_sales", force: :cascade do |t|
    t.datetime "sale_date"
    t.integer "quantity"
    t.bigint "product_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_product_sales_on_client_id"
    t.index ["product_id"], name: "index_product_sales_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "product_type"
    t.string "model"
    t.decimal "price"
    t.integer "inventory"
    t.boolean "high_tech"
    t.boolean "rentable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rent_products", force: :cascade do |t|
    t.decimal "price_hour"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_rent_products_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "email"
    t.integer "profile"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
