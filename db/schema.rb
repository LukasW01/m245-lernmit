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

ActiveRecord::Schema.define(version: 20_211_201_123_306) do
  create_table 'tasks', force: :cascade do |t|
    t.string 'title'
    t.string 'text'
    t.boolean 'done'
    t.string 'types'
    t.datetime 'due_date'
    t.integer 'points'
    t.integer 'tenant_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[tenant_id created_at], name: 'index_tasks_on_tenant_id_and_created_at'
  end

  create_table 'tenants', force: :cascade do |t|
    t.bigint 'schema_version'
    t.string 'role', default: 'user'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

end
