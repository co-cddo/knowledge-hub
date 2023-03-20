class ItemsSearch
  INDEX = ItemsIndex

  def self.search(**args)
    new(**args).search
  end

  attr_reader :query, :location_id

  def initialize(query:, location_id: nil)
    @query = query
    @location_id = location_id
  end

  def search
    if query.present?
      index.query(
        query_string: {
          fields: %i[name description tag_list remote_content],
          query:,
          default_operator: "and",
        },
      )
    end
  end

  def index
    return location_filter if location_id.present?

    INDEX
  end

  def location_filter
    INDEX.filter(match: { location_id: })
  end
end
