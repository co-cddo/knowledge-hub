# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/items", type: :request do
  let(:valid_attributes) do
    attributes_for :item, :for_params
  end

  let(:invalid_attributes) do
    {
      name: "",
      source_url: "invalid",
      description: "",
    }
  end
  let(:item) { create :item }
  let(:location) { item.location }

  before do
    mock_callout_to_source_url_on_item_save
  end

  describe "GET /locations/:location_id/items" do
    it "renders a successful response" do
      get location_items_path(location)
      expect(response).to be_successful
    end
  end

  describe "GET /locations/:location_id/items/:item_id" do
    subject(:render_show)  { get location_item_path(location, item) }
    it "renders a successful response" do
      render_show
      expect(response).to be_successful
    end

    it "records view" do
      expect { render_show }.to change(item.item_views, :count).by(1)
    end
  end

  describe "GET /locations/:location_id/items/new" do
    it "renders a successful response" do
      get new_location_item_path(location)
      expect(response).to be_successful
    end
  end

  describe "GET /locations/:location_id/items/:item_id/edit" do
    it "renders a successful response" do
      get edit_location_item_path(location, item)
      expect(response).to be_successful
    end
  end

  describe "POST /locations/:location_id/items" do
    let(:location) { create :location }
    context "with valid parameters" do
      it "creates a new Item" do
        expect {
          post location_items_path(location), params: { item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it "redirects to the created item" do
        post location_items_path(location), params: { item: valid_attributes }
        expect(response).to redirect_to(location_item_path(location, Item.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Item" do
        expect {
          post location_items_path(location), params: { item: invalid_attributes }
        }.to change(Item, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post location_items_path(location), params: { item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /locations/:location_id/items/:item_id" do
    context "with valid parameters" do
      let(:new_attributes) { attributes_for :item, :for_params }

      it "updates the requested item" do
        patch location_item_path(location, item), params: { item: new_attributes }
        item.reload
        expect(item.name).to eq(new_attributes[:name])
      end

      it "redirects to the item" do
        patch location_item_path(location, item), params: { item: new_attributes }
        item.reload
        expect(response).to redirect_to(location_item_path(location, item))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch location_item_path(location, item), params: { item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with multiple tags" do
      let(:tags) { %w[foo bar] }
      let(:attributes) do
        attributes_for :item, tag_list: tags.map { |t| { value: t } }.to_json
      end

      it "associates the tags with the item" do
        patch location_item_path(location, item), params: { item: attributes }
        expect(item.reload.tag_list).to match_array(tags)
      end
    end
  end

  describe "DELETE /locations/:location_id/items/:item_id" do
    it "destroys the requested item" do
      item # create item before action to ensure count correct
      expect {
        delete location_item_path(location, item)
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      delete location_item_path(location, item)
      expect(response).to redirect_to(location_items_path(location))
    end
  end
end
