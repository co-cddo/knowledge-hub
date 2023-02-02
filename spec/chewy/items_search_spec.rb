# frozen_string_literal: true

require "rails_helper"

RSpec.describe ItemsSearch, elasticsearch: true do
  describe ".search" do
    let(:text) { Faker::Lorem.word }
    let!(:item) { create :item, name: "Foo #{text} bar" }

    it "returns the item if name matches" do
      ItemsIndex.import
      expect(described_class.search(text).documents).to include(item)
    end
  end
end
