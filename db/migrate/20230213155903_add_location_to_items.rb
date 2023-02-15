class AddLocationToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :location, null: false, foreign_key: true
  end
end
