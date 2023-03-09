class ItemView < ApplicationRecord
  RECENT_PERIOD = 1.week.freeze

  belongs_to :item

  scope :recent, -> { where(arel_table[:created_at].gt(RECENT_PERIOD.ago)) }

  def self.most_popular_item
    # If new views exist just use those to determine popularity. Otherwise use all
    item_views = recent.exists? ? recent : all

    # Get a hash where the keys are item ids and the values the occurance count
    item_id_and_count_hash = item_views.group(:item_id).count(:item_id)

    return nil if item_id_and_count_hash.empty?

    # Find the first pair with the maximum occurances
    max_item_id_count = item_id_and_count_hash.max_by(&:last)

    # Extract the id from the max pair
    item_id = max_item_id_count.first

    # Return the matching item
    Item.find(item_id)
  end
end
