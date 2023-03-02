# Returns the

class ContentScraper
  def self.call(url)
    new(url).content
  end

  attr_reader :url

  TAGS_TO_EXCLUDE = %w[style script].freeze

  def initialize(url)
    @url = url
  end

  def content
    HtmlParser.call(response.body)
  end

private

  def response
    Faraday.get(url)
  end

  delegate :body, to: :response
end
