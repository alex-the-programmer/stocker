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

ActiveRecord::Schema.define(version: 2019_01_06_044014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charts", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.date "date"
    t.float "open"
    t.float "high"
    t.float "low"
    t.float "close"
    t.bigint "volume"
    t.float "vwap"
    t.index ["company_id", "date"], name: "index_charts_on_company_id_and_date"
    t.index ["company_id"], name: "index_charts_on_company_id"
  end

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
    t.boolean "cheap", default: false, null: false
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

  create_table "stats", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.float "marketcap"
    t.float "beta"
    t.float "week_52_high"
    t.float "week_52_low"
    t.float "week_52_change"
    t.float "short_interest"
    t.integer "short_date"
    t.float "dividend_rate"
    t.float "dividend_yield"
    t.date "ex_dividend_date"
    t.float "latest_eps"
    t.date "latest_eps_date"
    t.bigint "shares_outstanding"
    t.float "float"
    t.float "return_on_equity"
    t.float "consensus_eps"
    t.integer "number_of_estimates"
    t.float "eps_surprise_dollar"
    t.float "eps_surprise_percent"
    t.float "ebitda"
    t.float "revenue"
    t.float "gross_profit"
    t.float "cash"
    t.float "debt"
    t.float "ttm_eps"
    t.float "revenue_per_share"
    t.float "revenue_per_employee"
    t.float "pe_ratioH_high"
    t.float "pe_ratio_low"
    t.float "return_on_assets"
    t.float "return_on_capital"
    t.float "profit_margin"
    t.float "price_to_sales"
    t.float "price_to_book"
    t.float "day_20_moving_avg"
    t.float "day_50_moving_avg"
    t.float "institution_percent"
    t.float "insider_percent"
    t.float "short_ratio"
    t.float "year_5_change_percent"
    t.float "year_2_change_percent"
    t.float "year_1_change_percent"
    t.float "ytd_change_percent"
    t.float "month_6_change_percent"
    t.float "month_3_change_percent"
    t.float "month_1_change_percent"
    t.float "day_5_change_percent"
    t.float "day_30_change_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_stats_on_company_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  add_foreign_key "charts", "companies"
  add_foreign_key "companies", "sectors"
  add_foreign_key "companies_tags", "companies"
  add_foreign_key "companies_tags", "tags"
  add_foreign_key "sector_performances", "sectors"
  add_foreign_key "stats", "companies"
end
