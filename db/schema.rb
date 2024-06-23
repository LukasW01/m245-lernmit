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

ActiveRecord::Schema[7.1].define(version: 20_240_623_162_123) do
  create_table 'achievement_users', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'achievements_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'achievements', force: :cascade do |t|
    t.string 'image'
    t.string 'title'
    t.string 'desc'
  end

  create_table 'groups', force: :cascade do |t|
    t.string 'name'
    t.string 'desc'
    t.integer 'size'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'streaks', force: :cascade do |t|
    t.integer 'user_id'
    t.datetime 'created_at'
    t.string 'types'
  end

  create_table 'tasks', force: :cascade do |t|
    t.string 'title'
    t.string 'text'
    t.string 'status', default: 'upcoming'
    t.string 'types'
    t.datetime 'due_date'
    t.integer 'points'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_tasks_on_user_id'
  end

  create_table 'user_groups', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'group_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email', null: false
    t.string 'encrypted_password', limit: 128, null: false
    t.string 'roles', default: 'user', null: false
    t.string 'confirmation_token', limit: 128
    t.string 'remember_token', limit: 128, null: false
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email'
    t.index ['remember_token'], name: 'index_users_on_remember_token', unique: true
  end
end
