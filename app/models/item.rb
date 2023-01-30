# frozen_string_literal: true

# An item is a container that holds information about a remote document/object,
# including its location (source url)
# Items can be nested, so items relating to an item can be arranged as children
# of that item. The top level items are roots.
class Item < ApplicationRecord
  acts_as_nested_set counter_cache: "children_count"
  acts_as_taggable_on :tags

  validates :name, :description, presence: true
  validates :source_url, url: true
end
