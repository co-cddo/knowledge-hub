class ItemsIndex < Chewy::Index
  index_scope Item
  field :name
  field :description
  field :tag_list
  field :remote_content
  field :location_id
end
