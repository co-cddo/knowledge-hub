# frozen_string_literal: true

require "rails_helper"

RSpec.describe HtmlScraper do
  let(:url) { "http://example.com" }
  let(:body) { "something" }
  let(:html_scraper) { described_class.new(url) }

  before do
    stub_request(:get, url).to_return(body:)
  end

  describe "#body" do
    it "returns response body" do
      expect(html_scraper.body).to eq(body)
    end
  end

  describe ".call" do
    let(:body) do
      <<~HTML
        <!DOCTYPE html>
        <html lang="en" class="govuk-template ">
          <head>
            <title>Blank page</title>
            <style type="text/css">
                body {
                    background-color: #ffffff;
                }
            </style>
          </head>
          <body>
            <h1>Foo</h1>
            <p>Bar</p>
            <script>
              document.getElementById("example").innerHTML = "Hello JavaScript!";
            </script>
          </body>
        </html>
      HTML
    end

    it "returns stripped content" do
      expect(described_class.call(url)).to eq("Blank page Foo Bar")
    end
  end
end
