# frozen_string_literal: true

require "rails_helper"

RSpec.describe Item, type: :model do
  let(:item) { create :item }
  describe "#source_url" do
    it "is valid with a url" do
      expect(item).to be_valid
    end

    it "is invalid if not a url" do
      item.source_url = "invalid"
      expect(item).to be_invalid
    end
  end
end
