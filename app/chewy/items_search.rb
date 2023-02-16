class ItemsSearch
  INDEX = ItemsIndex

  def self.search(query)
    new(query).search
  end

  attr_reader :query

  def initialize(query)
    @query = query
  end

  def search
    if query.present?
      INDEX.query(
        query_string: {
          fields: %i[name description tag_list remote_content],
          query:,
          default_operator: "and",
        },
      )
    end
  end
end
