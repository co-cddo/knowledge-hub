# frozen_string_literal: true

require "rails_helper"

RSpec.describe HtmlParser do
  describe ".call" do
    let(:html) do
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

    it "returns processed content" do
      expect(described_class.call(html)).to eq("Blank page Foo Bar")
    end
  end
end
