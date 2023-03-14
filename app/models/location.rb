# frozen_string_literal: true

# An location is a container that holds information about where documents are located
# Locations can be nested, so sub-locations can be arranged as children of a location.
# The top level locations are roots.
class Location < ApplicationRecord
  has_many :items, dependent: :restrict_with_error

  acts_as_nested_set counter_cache: "children_count"
  acts_as_taggable_on :tags

  validates :name, :description, presence: true

  update_index("locations") { self }
end
