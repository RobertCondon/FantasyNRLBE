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

ActiveRecord::Schema[7.0].define(version: 2024_01_02_094320) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.integer "away_roster_id"
    t.integer "home_roster_id"
    t.string "score"
    t.integer "round"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "winner_id"
    t.integer "year"
    t.index ["away_roster_id"], name: "index_matches_on_away_roster_id"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_roster_id"], name: "index_matches_on_home_roster_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["year"], name: "index_matches_on_year"
  end

  create_table "player_rounds", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "team_id"
    t.bigint "roster_id"
    t.integer "number"
    t.string "position"
    t.string "minutes_played"
    t.integer "points"
    t.integer "tries"
    t.integer "conversions"
    t.integer "conversion_attempts"
    t.integer "penalty_goals"
    t.string "goal_conversion_rate"
    t.integer "one_point_field_goals"
    t.integer "two_point_field_goals"
    t.integer "total_points"
    t.integer "all_runs"
    t.integer "all_run_meters"
    t.integer "kick_return_meters"
    t.integer "post_contact_meters"
    t.integer "line_breaks"
    t.integer "line_break_assists"
    t.integer "try_assists"
    t.integer "line_engaged_runs"
    t.integer "tackle_breaks"
    t.integer "play_the_ball"
    t.string "average_play_the_ball_speed"
    t.integer "dummy_half_runs"
    t.integer "dummy_half_run_meters"
    t.integer "one_on_one_steal"
    t.integer "offloads"
    t.integer "dummy_passes"
    t.integer "passes"
    t.integer "receipts"
    t.string "passes_to_run_ratio"
    t.string "tackle_efficiency"
    t.integer "tackles_made"
    t.integer "missed_tackles"
    t.integer "ineffective_tackles"
    t.integer "intercepts"
    t.integer "kicks_defused"
    t.integer "kicks"
    t.integer "kick_meters"
    t.integer "bomb_kicks"
    t.integer "grubber_kicks"
    t.integer "forty_twenties"
    t.integer "twenty_forties"
    t.integer "cross_field_kicks"
    t.integer "kicks_dead"
    t.integer "player_errors"
    t.integer "handling_errors"
    t.integer "one_on_one_lost"
    t.integer "penalties"
    t.integer "ruck_infringements"
    t.integer "inside_10_meters"
    t.integer "on_report"
    t.integer "sin_bins"
    t.integer "send_offs"
    t.string "stint_one"
    t.string "stint_two"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hit_ups"
    t.integer "fantasy_points_total"
    t.integer "field_goals"
    t.integer "forced_drop_out_kicks"
    t.integer "goals"
    t.integer "hit_up_run_meters"
    t.integer "offside_within_ten_meters"
    t.decimal "play_the_ball_average_speed"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.integer "fantasy_points_total"
    t.decimal "fantasy_points_average"
    t.integer "cost"
    t.decimal "owned_by"
    t.integer "nrl_id"
    t.string "status"
  end

  create_table "rosters", force: :cascade do |t|
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.integer "ladder_position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "nrl_id"
  end

end
