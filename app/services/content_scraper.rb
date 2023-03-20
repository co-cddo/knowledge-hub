# Returns the content from a remote resource
class ContentScraper
  require "faraday/follow_redirects"

  def self.call(url)
    new(url).content
  end

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def content
    case headers["content-type"]
    when /text\/html/
      HtmlParser.call(body)
    when /application\/pdf/
      PdfParser.call(body)
    when /text\/plain/
      body
    end
    # TODO: Determine best strategy to handle unknown content types
    #       (and other errors). Currently this method will return nil
  end

private

  def response
    conn = Faraday.new do |faraday|
      faraday.response :follow_redirects
    end

    conn.get(url)
  end

  delegate :body, :headers, to: :response
end
