# frozen_string_literal: true

require "rails_helper"

RSpec.describe ItemsSearch, elasticsearch: true do
  describe ".search" do
    let(:text) { Faker::Lorem.word }
    let(:source_url) { Faker::Internet.url }
    let(:item) { create :item, name: "Foo #{text} bar", source_url: }
    let(:remote_content) { Faker::Lorem.word }

    before do
      mock_callout_to_source_url_on_item_save(remote_content:)
      item
      ItemsIndex.import
    end

    it "returns the item if name matches" do
      expect(described_class.search(text).documents).to include(item)
    end

    it "returns the item if the remote content matches" do
      expect(described_class.search(remote_content).documents).to include(item)
    end

    it "does not return anything if there is no match" do
      expect(described_class.search("XXXX").documents).to be_empty
    end
  end
end
