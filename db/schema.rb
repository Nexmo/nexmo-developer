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

ActiveRecord::Schema.define(version: 2019_04_15_162421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_admin_comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.uuid "resource_id"
    t.string "author_type"
    t.uuid "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
  end

  create_table "careers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.boolean "published"
    t.string "location"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "summary"
    t.string "icon"
    t.string "slug"
    t.text "description_short"
    t.string "role_group"
    t.index ["published"], name: "index_careers_on_published"
    t.index ["role_group"], name: "index_careers_on_role_group"
    t.index ["slug"], name: "index_careers_on_slug"
  end

  create_table "events", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.date "starts_at", null: false
    t.date "ends_at", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ends_at"], name: "index_events_on_ends_at"
    t.index ["starts_at"], name: "index_events_on_starts_at"
  end

  create_table "feedback_authors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_feedback_authors_on_email"
  end

  create_table "feedback_feedbacks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "sentiment", null: false
    t.uuid "resource_id", null: false
    t.uuid "owner_id", null: false
    t.string "owner_type", null: false
    t.string "ip", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code_language"
    t.boolean "code_language_selected_whilst_on_page"
    t.boolean "code_language_set_by_url"
    t.boolean "resolved", default: false, null: false
    t.index ["code_language"], name: "index_feedback_feedbacks_on_code_language"
    t.index ["code_language_selected_whilst_on_page"], name: "index_feedbacks_on_code_language_selected_whilst_on_page"
    t.index ["code_language_set_by_url"], name: "index_feedbacks_on_code_language_set_by_url"
    t.index ["ip"], name: "index_feedback_feedbacks_on_ip"
    t.index ["owner_id", "owner_type"], name: "index_feedback_feedbacks_on_owner_id_and_owner_type"
    t.index ["resolved"], name: "index_feedback_feedbacks_on_resolved"
    t.index ["resource_id"], name: "index_feedback_feedbacks_on_resource_id"
    t.index ["sentiment"], name: "index_feedback_feedbacks_on_sentiment"
  end

  create_table "feedback_resources", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "uri", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product"
    t.index ["product"], name: "index_feedback_resources_on_product"
    t.index ["uri"], name: "index_feedback_resources_on_uri", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "redirects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "url"
    t.integer "uses"
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "author"
    t.uuid "event_id"
    t.string "video_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published"
    t.index ["published"], name: "index_sessions_on_published"
  end

  create_table "usage_code_snippet_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "language", null: false
    t.string "snippet", null: false
    t.string "section", null: false
    t.string "action", null: false
    t.string "ip", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action"], name: "index_usage_code_snippet_events_on_action"
    t.index ["ip"], name: "index_usage_code_snippet_events_on_ip"
    t.index ["language"], name: "index_usage_code_snippet_events_on_language"
    t.index ["snippet"], name: "index_usage_code_snippet_events_on_snippet"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key"
    t.string "api_secret"
    t.string "nexmo_developer_api_secret", null: false
    t.index ["admin"], name: "index_users_on_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
