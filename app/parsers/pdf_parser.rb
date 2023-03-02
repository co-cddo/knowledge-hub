# Extracts the content from a PDF document
class PdfParser
  def self.call(pdf)
    new(pdf).process
  end

  attr_reader :pdf

  def initialize(pdf)
    @pdf = pdf
  end

  def process
    content.gsub(/[[:space:]]+/, " ")
  end

private

  def content
    document.pages.map(&:text).join(" ")
  end

  def document
    PDF::Reader.new(pdf_as_string_io)
  end

  def pdf_as_string_io
    StringIO.new(pdf)
  end
end
