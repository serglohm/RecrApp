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

ActiveRecord::Schema.define(version: 20180729121323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.bigint "candidate_id"
    t.bigint "vacancy_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "finish_date"
    t.boolean "rejected", default: false
    t.string "reject_reason"
    t.boolean "withdrawn", default: false
    t.string "withdrawn_reason"
    t.boolean "hired", default: false
    t.integer "salary"
    t.date "start_date"
    t.boolean "offer_rejected", default: false
    t.string "offer_rejected_reason"
    t.boolean "invoiced", default: false
    t.index ["candidate_id"], name: "index_assignments_on_candidate_id"
    t.index ["vacancy_id"], name: "index_assignments_on_vacancy_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "status"
    t.string "country"
    t.string "education"
    t.text "experience"
    t.string "expected_salary"
    t.string "marital_status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "linked_in"
    t.string "github"
    t.string "resume"
    t.bigint "source_id"
    t.string "skype"
    t.string "email"
    t.string "availability"
    t.text "spoken_languages"
    t.string "city"
    t.string "phone"
    t.index ["source_id"], name: "index_candidates_on_source_id"
    t.index ["user_id"], name: "index_candidates_on_user_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.integer "chat_id"
    t.integer "vacancy_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_sent"
    t.index ["chat_id", "vacancy_id"], name: "index_chat_messages_on_chat_id_and_vacancy_id"
  end

  create_table "chats", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "candidate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_comments_on_candidate_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description_ru"
    t.text "description_en"
    t.decimal "rate"
    t.integer "pay_type", default: 0
  end

  create_table "events", force: :cascade do |t|
    t.bigint "assignment_id"
    t.datetime "scheduled_on"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["assignment_id"], name: "index_events_on_assignment_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "skill_abilities", force: :cascade do |t|
    t.bigint "candidate_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_skill_abilities_on_candidate_id"
    t.index ["skill_id"], name: "index_skill_abilities_on_skill_id"
  end

  create_table "skill_requirements", force: :cascade do |t|
    t.bigint "vacancy_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_skill_requirements_on_skill_id"
    t.index ["vacancy_id"], name: "index_skill_requirements_on_vacancy_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "assignable_id"
    t.string "assignable_type"
    t.index ["assignable_type", "assignable_id"], name: "index_skills_on_assignable_type_and_assignable_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "short_name"
    t.string "author_name"
    t.string "author_url"
    t.string "auth_url"
    t.string "access_token"
    t.text "vacancy_footer"
    t.integer "telegram_api_id"
    t.string "telegram_api_hash"
    t.string "phone_number"
    t.boolean "active", default: true
    t.integer "pay_type", default: 0
    t.integer "rate_per_candidate", default: 0
    t.integer "base_salary", default: 0
    t.integer "salary_threshold", default: 0
    t.integer "bonus_salary_rate", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "vacancies", force: :cascade do |t|
    t.string "name"
    t.string "telegraph_link_ru"
    t.string "telegraph_link_en"
    t.text "description"
    t.integer "salary_min"
    t.integer "salary_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.boolean "closed"
    t.string "job_link"
    t.text "telegram_desc_ru"
    t.text "telegram_desc_en"
    t.index ["company_id"], name: "index_vacancies_on_company_id"
  end

  add_foreign_key "assignments", "candidates"
  add_foreign_key "assignments", "vacancies"
  add_foreign_key "candidates", "sources"
  add_foreign_key "candidates", "users"
  add_foreign_key "chats", "users"
  add_foreign_key "comments", "candidates"
  add_foreign_key "comments", "users"
  add_foreign_key "events", "assignments"
  add_foreign_key "skill_abilities", "candidates"
  add_foreign_key "skill_abilities", "skills"
  add_foreign_key "skill_requirements", "skills"
  add_foreign_key "skill_requirements", "vacancies"
  add_foreign_key "vacancies", "companies"
end
