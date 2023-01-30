class RemoveTagsFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :tags, :string
  end
end
