# frozen_string_literal: true

require "rails_helper"

RSpec.describe PdfParser do
  let(:pdf) { file_fixture("dummy.pdf").read }

  describe ".call" do
    it "returns processed content" do
      expect(described_class.call(pdf)).to eq("Dummy PDF file")
    end
  end
end
