# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContentScraper do
  let(:url) { "http://example.com" }
  let(:body) { "something" }
  let(:html_scraper) { described_class.new(url) }
  let(:content_type) { "text/plain" }

  before do
    stub_request(:get, url).to_return(
      body:,
      headers: { "Content-type" => content_type },
    )
  end

  describe ".call" do
    it "returns content of response" do
      expect(described_class.call(url)).to eq(body)
    end

    context "when HTML" do
      let(:body) { file_fixture("simple.html") }
      let(:content_type) { "text/html" }

      it "returns stripped document content" do
        expect(described_class.call(url)).to eq("Blank page Foo Bar")
      end
    end

    context "with PDF" do
      let(:body) { file_fixture("dummy.pdf") }
      let(:content_type) { "application/pdf" }

      it "returns the text from the document" do
        expect(described_class.call(url)).to eq("Dummy PDF file")
      end
    end

    context "with unknown content" do
      let(:content_type) { "unknown" }

      it "returns nil" do
        expect(described_class.call(url)).to be_nil
      end
    end
  end
end
