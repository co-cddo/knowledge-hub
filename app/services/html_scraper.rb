# Returns the

class HtmlScraper
  def self.call(url)
    new(url).stripped_content
  end

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def stripped_content
    content.strip.gsub(/[[:space:]]+/, " ")
  end

private

  def document
    Nokogiri::HTML(body)
  end

  def response
    Faraday.get(url)
  end

  delegate :body, to: :response
  delegate :content, to: :document
end
