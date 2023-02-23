# Returns the

class HtmlScraper
  def self.call(url)
    new(url).stripped_content
  end

  attr_reader :url

  TAGS_TO_EXCLUDE = %w[style script].freeze

  def initialize(url)
    @url = url
  end

  def stripped_content
    content.strip.gsub(/[[:space:]]+/, " ")
  end

private

  def document
    document = Nokogiri::HTML(body)
    TAGS_TO_EXCLUDE.each do |tag|
      document.search(tag).remove
    end
    document
  end

  def response
    Faraday.get(url)
  end

  delegate :body, to: :response
  delegate :content, to: :document
end
