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

ActiveRecord::Schema[7.0].define(version: 2023_07_31_005819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "work_models_enum", ["onsite", "hybrid", "remote"]

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "receiver_id", null: false
    t.string "referenceable_type", null: false
    t.bigint "referenceable_id", null: false
    t.integer "overall_rating", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.jsonb "data", default: {}, null: false
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_feedbacks_on_author_id"
    t.index ["receiver_id"], name: "index_feedbacks_on_receiver_id"
    t.index ["referenceable_type", "referenceable_id"], name: "index_feedbacks_on_referenceable"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "pair_requests", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "invitee_id", null: false
    t.datetime "when", null: false
    t.integer "duration", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_pair_requests_on_author_id"
    t.index ["invitee_id"], name: "index_pair_requests_on_invitee_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "bio"
    t.string "job_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.integer "job_search_status", default: 0
    t.enum "work_model_preferences", array: true, enum_type: "work_models_enum"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "standup_attendances", force: :cascade do |t|
    t.bigint "standup_meeting_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["standup_meeting_id"], name: "index_standup_attendances_on_standup_meeting_id"
    t.index ["user_id"], name: "index_standup_attendances_on_user_id"
  end

  create_table "standup_meeting_groups", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.time "start_time", null: false
    t.integer "frequency", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "standup_meeting_groups_users", force: :cascade do |t|
    t.bigint "standup_meeting_group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["standup_meeting_group_id", "user_id"], name: "index_smg_users_on_smg_id_and_user_id"
    t.index ["user_id", "standup_meeting_group_id"], name: "index_smg_users_on_user_id_and_smg_id"
  end

  create_table "standup_meetings", force: :cascade do |t|
    t.bigint "standup_meeting_group_id", null: false
    t.bigint "user_id", null: false
    t.text "yesterday_work_description"
    t.text "today_work_description"
    t.text "blockers_description"
    t.date "meeting_date", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["standup_meeting_group_id"], name: "index_standup_meetings_on_standup_meeting_group_id"
    t.index ["user_id"], name: "index_standup_meetings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "time_zone", default: "UTC", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "feedbacks", "users", column: "author_id"
  add_foreign_key "feedbacks", "users", column: "receiver_id"
  add_foreign_key "pair_requests", "users", column: "author_id"
  add_foreign_key "pair_requests", "users", column: "invitee_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "standup_attendances", "standup_meetings"
  add_foreign_key "standup_attendances", "users"
  add_foreign_key "standup_meetings", "standup_meeting_groups"
  add_foreign_key "standup_meetings", "users"
end
