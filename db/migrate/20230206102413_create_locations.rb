class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, index: true
      t.text :description
      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0

      t.timestamps
    end
  end
end
