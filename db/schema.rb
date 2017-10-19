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

ActiveRecord::Schema.define(version: 20171019083543) do

  create_table "availabilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "advance_notice"
    t.string   "maximum_advance_notice_time"
    t.integer  "minimum_rental"
    t.integer  "maximum_rental"
    t.string   "dropoff_time"
    t.string   "pickup_time"
    t.integer  "listing_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "bikes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "size"
    t.boolean  "lights",             default: false
    t.integer  "listing_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "listings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "listed",      default: false
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "route"
    t.integer  "street_number"
    t.string   "locality"
    t.integer  "postal_code"
    t.float    "latitude",      limit: 24
    t.float    "longitude",     limit: 24
    t.string   "country_code"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "listing_id"
  end

  create_table "pricings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "base_price"
    t.integer  "average_weekly"
    t.integer  "average_monthly"
    t.string   "currency"
    t.integer  "weekend_pricing"
    t.integer  "security_deposit"
    t.integer  "maintenance_fee"
    t.integer  "listing_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
