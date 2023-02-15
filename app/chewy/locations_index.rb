class LocationsIndex < Chewy::Index
  index_scope Location
  field :name
  field :description
  field :tag_list
end
