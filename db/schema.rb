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

ActiveRecord::Schema.define(version: 2019_01_04_021836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "symbol", null: false
    t.string "name", null: false
    t.string "exchange"
    t.string "industry"
    t.string "website"
    t.string "description"
    t.string "ceo"
    t.string "issue_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sector_id"
    t.index ["symbol"], name: "index_companies_on_symbol", unique: true
  end

  create_table "companies_tags", id: false, force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "tag_id", null: false
  end

  create_table "sector_performances", force: :cascade do |t|
    t.bigint "sector_id", null: false
    t.decimal "performance", null: false
    t.date "period", null: false
    t.date "last_updated", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sector_id", "last_updated"], name: "index_sector_performances_on_sector_id_and_last_updated", unique: true
    t.index ["sector_id"], name: "index_sector_performances_on_sector_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sectors_on_name", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  add_foreign_key "companies", "sectors"
  add_foreign_key "companies_tags", "companies"
  add_foreign_key "companies_tags", "tags"
  add_foreign_key "sector_performances", "sectors"
end
