require "rails_helper"

RSpec.describe "/locations", type: :request do
  let(:valid_attributes) do
    attributes_for :location, :for_params
  end

  let(:invalid_attributes) do
    {
      name: "",
      description: "",
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Location.create! valid_attributes
      get locations_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      location = Location.create! valid_attributes
      get location_url(location)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_location_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      location = Location.create! valid_attributes
      get edit_location_url(location)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Location" do
        expect {
          post locations_url, params: { location: valid_attributes }
        }.to change(Location, :count).by(1)
      end

      it "redirects to the created location" do
        post locations_url, params: { location: valid_attributes }
        expect(response).to redirect_to(location_url(Location.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Location" do
        expect {
          post locations_url, params: { location: invalid_attributes }
        }.to change(Location, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post locations_url, params: { location: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    let(:location) { create :location }

    context "with valid parameters" do
      it "updates the requested location" do
        patch location_url(location), params: { location: valid_attributes }
        location.reload
        expect(location.name).to eq(valid_attributes[:name])
      end

      it "redirects to the location" do
        patch location_url(location), params: { location: valid_attributes }
        location.reload
        expect(response).to redirect_to(location_url(location))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch location_url(location), params: { location: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested location" do
      location = Location.create! valid_attributes
      expect {
        delete location_url(location)
      }.to change(Location, :count).by(-1)
    end

    it "redirects to the locations list" do
      location = Location.create! valid_attributes
      delete location_url(location)
      expect(response).to redirect_to(locations_url)
    end
  end
end
