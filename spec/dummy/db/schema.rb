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

ActiveRecord::Schema[7.1].define(version: 2024_03_18_150906) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "tiers_mode", ["graduated", "volume"]
  create_enum "usage_type", ["metered", "licensed"]

  create_table "billing_manager_bundle_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "bundle_id"
    t.uuid "price_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bundle_id"], name: "index_billing_manager_bundle_items_on_bundle_id"
    t.index ["price_id"], name: "index_billing_manager_bundle_items_on_price_id"
  end

  create_table "billing_manager_bundles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "owner_id"
    t.string "label", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_billing_manager_bundles_on_owner_id"
  end

  create_table "billing_manager_customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "owner_id"
    t.string "stripe_id"
    t.jsonb "stripe_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_billing_manager_customers_on_owner_id"
    t.index ["stripe_id"], name: "index_billing_manager_customers_on_stripe_id", unique: true
  end

  create_table "billing_manager_features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "owner_id"
    t.string "label", null: false
    t.text "description"
    t.string "stripe_id"
    t.jsonb "stripe_data"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_billing_manager_features_on_owner_id"
    t.index ["stripe_id"], name: "index_billing_manager_features_on_stripe_id", unique: true
  end

  create_table "billing_manager_owners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "parent_type"
    t.string "parent_id"
    t.string "stripe_publishable_key", null: false
    t.string "stripe_secret_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_manager_price_tiers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "price_id"
    t.float "flat_amount"
    t.float "unit_amount"
    t.integer "up_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_id", "flat_amount", "unit_amount", "up_to"], name: "unique_tiers", unique: true
    t.index ["price_id"], name: "index_billing_manager_price_tiers_on_price_id"
  end

  create_table "billing_manager_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "feature_id"
    t.string "label", null: false
    t.float "price"
    t.boolean "recurring", default: false, null: false
    t.integer "recurring_interval"
    t.integer "recurring_interval_count"
    t.enum "usage_type", enum_type: "usage_type"
    t.enum "tiers_mode", enum_type: "tiers_mode"
    t.string "stripe_id"
    t.jsonb "stripe_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_billing_manager_prices_on_feature_id"
    t.index ["stripe_id"], name: "index_billing_manager_prices_on_stripe_id", unique: true
    t.check_constraint "price IS NOT NULL OR tiers_mode IS NOT NULL", name: "price_presence_constraint"
  end

  create_table "billing_manager_record_usages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "subscription_item_id"
    t.string "stripe_id", null: false
    t.jsonb "stripe_data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_item_id"], name: "index_billing_manager_record_usages_on_subscription_item_id"
  end

  create_table "billing_manager_subscription_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "subscription_id"
    t.uuid "price_id"
    t.integer "quantity", default: 1, null: false
    t.string "stripe_id"
    t.jsonb "stripe_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_id"], name: "index_billing_manager_subscription_items_on_price_id"
    t.index ["stripe_id"], name: "index_billing_manager_subscription_items_on_stripe_id", unique: true
    t.index ["subscription_id", "price_id"], name: "unique_price_feature", unique: true
    t.index ["subscription_id"], name: "index_billing_manager_subscription_items_on_subscription_id"
  end

  create_table "billing_manager_subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "customer_id"
    t.string "stripe_id"
    t.jsonb "stripe_data"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_billing_manager_subscriptions_on_customer_id"
    t.index ["stripe_id"], name: "index_billing_manager_subscriptions_on_stripe_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "billing_manager_bundle_items", "billing_manager_bundles", column: "bundle_id"
  add_foreign_key "billing_manager_bundle_items", "billing_manager_prices", column: "price_id"
  add_foreign_key "billing_manager_bundles", "billing_manager_owners", column: "owner_id"
  add_foreign_key "billing_manager_customers", "billing_manager_owners", column: "owner_id"
  add_foreign_key "billing_manager_features", "billing_manager_owners", column: "owner_id"
  add_foreign_key "billing_manager_price_tiers", "billing_manager_prices", column: "price_id"
  add_foreign_key "billing_manager_prices", "billing_manager_features", column: "feature_id"
  add_foreign_key "billing_manager_record_usages", "billing_manager_subscription_items", column: "subscription_item_id"
  add_foreign_key "billing_manager_subscription_items", "billing_manager_prices", column: "price_id"
  add_foreign_key "billing_manager_subscription_items", "billing_manager_subscriptions", column: "subscription_id"
  add_foreign_key "billing_manager_subscriptions", "billing_manager_customers", column: "customer_id"
end
