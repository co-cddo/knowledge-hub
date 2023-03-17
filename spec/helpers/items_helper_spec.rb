# frozen_string_literal: true

require "rails_helper"

RSpec.describe ItemsHelper, type: :helper do
  let(:location) { create :location }
  let(:item) { create :item, location: }

  describe ".item_path" do
    it "returns the link to its location" do
      expect(helper.item_path(item)).to eq(location_item_path(location, item))
    end
  end

  describe ".item_breadcrumbs" do
    subject(:item_breadcrumbs) { helper.item_breadcrumbs(item) }

    it "only has the path to its location" do
      expect(item_breadcrumbs).to eq({ location.name => location_path(location) })
    end

    context "when the item has parents" do
      let(:parent) { create :item }
      let(:item) { create :item, parent: }

      it "has two elements" do
        expect(item_breadcrumbs.length).to eq(2)
      end

      it "has the path to the parents location first" do
        expect(item_breadcrumbs.to_a.first).to contain_exactly(parent.location.name, location_path(parent.location))
      end

      it "has the path to its parent second" do
        expect(item_breadcrumbs.to_a.last).to contain_exactly(parent.name, helper.item_path(parent))
      end
    end

    context "when the item has grandparents" do
      let(:grandparent) { create :item }
      let(:parent) { create :item, parent: grandparent }
      let(:item) { create :item, parent: }

      let(:grandparent_location_link) do
        [grandparent.location.name, location_path(grandparent.location)]
      end
      let(:grandparent_link) { [grandparent.name, helper.item_path(grandparent)] }
      let(:parent_link) { [parent.name, helper.item_path(parent)] }

      it "contains links to grandparent location, grandparent and parent" do
        expect(item_breadcrumbs).to contain_exactly(grandparent_location_link, grandparent_link, parent_link)
      end
    end

    context "when item's location has parents" do
      let(:parent_location) { create :location }
      let(:location) { create :location, parent: parent_location }

      it "has two elements" do
        expect(item_breadcrumbs.length).to eq(2)
      end

      it "has the path to the parent location first" do
        expect(item_breadcrumbs.to_a.first).to contain_exactly(parent_location.name, location_path(parent_location))
      end

      it "has the path to the item location second" do
        expect(item_breadcrumbs.to_a.last).to contain_exactly(location.name, location_path(location))
      end
    end
  end
end
