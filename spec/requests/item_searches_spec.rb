require "rails_helper"

RSpec.describe "ItemSearches", type: :request, elasticsearch: true do
  describe "GET /index" do
    it "returns http success" do
      get item_searches_path
      expect(response).to have_http_status(:success)
    end

    it "states nothing found" do
      get item_searches_path
      expect(response.body).to include("No results found")
    end

    context "when passed a query" do
      let(:text) { Faker::Lorem.word }
      let(:item) { create :item, name: "Foo #{text} bar" }

      before do
        item
        # ItemsIndex.import
      end

      it "displays a link to the matching item" do
        get item_searches_path, params: { query: text }
        expect(response.body).to include(location_item_path(item.location, item))
      end
    end
  end
end
