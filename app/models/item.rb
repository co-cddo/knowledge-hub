# frozen_string_literal: true

# An item is a container that holds information about a remote document/object,
# including its location (source url)
# Items can be nested, so items relating to an item can be arranged as children
# of that item. The top level items are roots.
class Item < ApplicationRecord
  acts_as_nested_set counter_cache: "children_count"
  acts_as_taggable_on :tags

  belongs_to :location
  has_many :comments

  validates :name, :description, presence: true
  validates :source_url, url: true

private

  def remote_content
    @remote_content ||= ContentScraper.call(source_url) if source_url.present?
  end

  update_index("items") { self }
end
