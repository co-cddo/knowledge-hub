require "rails_helper"

RSpec.describe "ItemSearches", type: :request, elasticsearch: true do
  describe "GET /item_searches" do
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
        mock_callout_to_source_url_on_item_save
        ItemsIndex.import
      end

      it "displays a link to the matching item" do
        get item_searches_path, params: { query: text }
        expect(response.body).to include(location_item_path(item.location, item))
      end
    end
  end

  describe "GET /locations/:id/search" do
    let(:location) { create :location }

    it "returns http success" do
      get search_location_path(location)
      expect(response).to have_http_status(:success)
    end

    it "states nothing found" do
      get search_location_path(location)
      expect(response.body).to include("No results found")
    end

    context "when passed a query" do
      let(:text) { Faker::Lorem.word }
      let(:item) { create :item, name: "Foo #{text} bar", location: }

      before do
        item
        mock_callout_to_source_url_on_item_save
        ItemsIndex.import
      end

      it "displays a link to the matching item" do
        get search_location_path(location), params: { query: text }
        expect(response.body).to include(location_item_path(item.location, item))
      end

      context "with a different location" do
        let(:different_location) { create :location }

        it "states nothing found" do
          get search_location_path(different_location), params: { query: text }
          expect(response.body).to include("No results found")
        end
      end

      context "with a sub-location" do
        let(:parent_location) { create :location }
        let(:location) { create :location, parent_id: parent_location.id }

        it "states nothing found" do
          get search_location_path(parent_location), params: { query: text }
          expect(response.body).to include("No results found")
        end
      end

      context "with a sub-location and include sub-locations selected" do
        let(:parent_location) { create :location }
        let(:location) { create :location, parent_id: parent_location.id }

        it "displays a link to the matching item" do
          get search_location_path(parent_location), params: { query: text, include_sub_locations: true }
          expect(response.body).to include(location_item_path(item.location, item))
        end
      end
    end
  end
end
