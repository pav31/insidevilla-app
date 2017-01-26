# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170123082201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.date     "move_in_at"
    t.date     "move_out_at"
    t.integer  "estate_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.integer  "adults",           default: 1
    t.integer  "kids",             default: 0
    t.text     "comment"
    t.boolean  "airport_transfer", default: false,     null: false
    t.boolean  "car_rental",       default: false,     null: false
    t.boolean  "escort_service",   default: false,     null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "status",           default: "pending", null: false
  end

  add_index "bookings", ["estate_id"], name: "index_bookings_on_estate_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comforts", force: :cascade do |t|
    t.integer  "category",          default: 1, null: false
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.hstore   "name_translations"
    t.string   "value"
  end

  create_table "estate_comforts", force: :cascade do |t|
    t.integer  "estate_id"
    t.integer  "comfort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "estate_comforts", ["comfort_id"], name: "index_estate_comforts_on_comfort_id", using: :btree
  add_index "estate_comforts", ["estate_id"], name: "index_estate_comforts_on_estate_id", using: :btree

  create_table "estates", force: :cascade do |t|
    t.string   "address"
    t.integer  "price_cents",                  limit: 8, default: 0,             null: false
    t.boolean  "featured"
    t.boolean  "available"
    t.boolean  "draft"
    t.string   "estate_type",                            default: "apartment",   null: false
    t.string   "tenure_type",                            default: "rent",        null: false
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.float    "area_size"
    t.integer  "bedrooms",                               default: 1,             null: false
    t.integer  "bathrooms",                              default: 1,             null: false
    t.hstore   "title_translations"
    t.hstore   "description_translations"
    t.string   "main_image_file_name"
    t.string   "main_image_content_type"
    t.integer  "main_image_file_size"
    t.datetime "main_image_updated_at"
    t.string   "slider_file_name"
    t.string   "slider_content_type"
    t.integer  "slider_file_size"
    t.datetime "slider_updated_at"
    t.integer  "sea_distance"
    t.string   "region",                                 default: "phuket_town", null: false
    t.integer  "price_day_low_cents",          limit: 8, default: 0,             null: false
    t.integer  "price_day_high_cents",         limit: 8, default: 0,             null: false
    t.integer  "price_day_pick_cents",         limit: 8, default: 0,             null: false
    t.integer  "price_week_low_cents",         limit: 8, default: 0,             null: false
    t.integer  "price_week_high_cents",        limit: 8, default: 0,             null: false
    t.integer  "price_week_pick_cents",        limit: 8, default: 0,             null: false
    t.integer  "price_month_low_cents",        limit: 8, default: 0,             null: false
    t.integer  "price_month_high_cents",       limit: 8, default: 0,             null: false
    t.integer  "price_month_pick_cents",       limit: 8, default: 0,             null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "closest_beach"
    t.integer  "toilets"
    t.integer  "double_beds"
    t.integer  "single_beds"
    t.string   "cleaning_period"
    t.float    "living_area"
    t.string   "photo_link"
    t.text     "comment"
    t.string   "commission_long_term"
    t.string   "commission_short_term"
    t.string   "owner_name"
    t.string   "owner_phone"
    t.string   "owner_email"
    t.integer  "admin_price_cents",            limit: 8, default: 0,             null: false
    t.integer  "admin_price_day_low_cents",    limit: 8, default: 0,             null: false
    t.integer  "admin_price_day_high_cents",   limit: 8, default: 0,             null: false
    t.integer  "admin_price_day_pick_cents",   limit: 8, default: 0,             null: false
    t.integer  "admin_price_week_low_cents",   limit: 8, default: 0,             null: false
    t.integer  "admin_price_week_high_cents",  limit: 8, default: 0,             null: false
    t.integer  "admin_price_week_pick_cents",  limit: 8, default: 0,             null: false
    t.integer  "admin_price_month_low_cents",  limit: 8, default: 0,             null: false
    t.integer  "admin_price_month_high_cents", limit: 8, default: 0,             null: false
    t.integer  "admin_price_month_pick_cents", limit: 8, default: 0,             null: false
    t.string   "estate_class",                                                   null: false
    t.text     "owner_comment"
    t.integer  "airport_distance"
    t.boolean  "we_manage",                              default: false,         null: false
    t.string   "place",                                  default: "phuket",      null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "estate_id",                          null: false
    t.string   "author"
    t.string   "email"
    t.string   "city"
    t.string   "occupation"
    t.text     "body"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "approved",           default: false, null: false
    t.boolean  "favorite",           default: false, null: false
  end

  add_index "feedbacks", ["estate_id"], name: "index_feedbacks_on_estate_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "dimensions"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "sliders", force: :cascade do |t|
    t.hstore   "title_translations"
    t.hstore   "text_translations"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "priority"
    t.boolean  "active"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "static_pages", force: :cascade do |t|
    t.integer  "category"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "slug"
    t.hstore   "title_translations"
    t.hstore   "content_translations"
    t.hstore   "meta"
    t.integer  "position"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "static_pages", ["slug"], name: "index_static_pages_on_slug", unique: true, using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.string   "email"
    t.string   "token"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
