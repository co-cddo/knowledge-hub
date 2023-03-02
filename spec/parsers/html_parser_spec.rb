# frozen_string_literal: true

require "rails_helper"

RSpec.describe HtmlParser do
  let(:html) { file_fixture("style_and_script.html") }

  describe ".call" do
    it "returns processed content" do
      expect(described_class.call(html)).to eq("Blank page Foo Bar")
    end
  end
end
