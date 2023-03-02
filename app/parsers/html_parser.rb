# Extracts the content from an HTML document
class HtmlParser
  TAGS_TO_EXCLUDE = %w[style script].freeze

  def self.call(html)
    new(html).process
  end

  attr_reader :html

  def initialize(html)
    @html = html
  end

  def process
    remove_excluded_tags
    remove_multiple_spaces
  end

  private

  def document
    @document ||= Nokogiri::HTML(html)
  end

  def remove_excluded_tags
    TAGS_TO_EXCLUDE.each do |tag|
      document.search(tag).remove
    end
  end

  def remove_multiple_spaces
    document.content.strip.gsub(/[[:space:]]+/, " ")
  end
end
