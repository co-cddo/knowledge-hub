# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_117_135_331) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'items', force: :cascade do |t|
    t.string 'name'
    t.string 'source_url'
    t.string 'tags'
    t.text 'description'
    t.integer 'parent_id'
    t.integer 'lft', null: false
    t.integer 'rgt', null: false
    t.integer 'depth', default: 0, null: false
    t.integer 'children_count', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['lft'], name: 'index_items_on_lft'
    t.index ['parent_id'], name: 'index_items_on_parent_id'
    t.index ['rgt'], name: 'index_items_on_rgt'
  end
end
