require "rails_helper"

RSpec.describe ItemView, type: :model do
  describe ".most_popular_item" do
    let(:popular) { create :item }
    let(:unpopular) { create :item }

    it "returns nil if no view items" do
      expect(described_class.most_popular_item).to eq(nil)
    end

    context "when view exist" do
      before do
        create :item_view, item: unpopular
        create_list :item_view, 2, item: popular
      end

      it "returns the most popular" do
        expect(described_class.most_popular_item).to eq(popular)
      end
    end

    context "when old and new views exist" do
      before do
        create :item_view, item: unpopular
        create_list :item_view, 2, item: popular
        create_list :item_view, 2, item: unpopular, created_at: 1.year.ago
      end

      it "returns the most popular new view item" do
        expect(described_class.most_popular_item).to eq(popular)
      end
    end

    context "when only old view exists" do
      before do
        create :item_view, item: unpopular, created_at: 1.year.ago
        create_list :item_view, 2, item: popular, created_at: 1.year.ago
      end

      it "returns the most popular old view item" do
        expect(described_class.most_popular_item).to eq(popular)
      end
    end
  end
end
