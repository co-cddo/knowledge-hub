require "rails_helper"

RSpec.describe "comments", type: :request do
  let(:valid_attributes) do
    attributes_for :comment
  end

  let(:invalid_attributes) do
    {
      body: "",
    }
  end

  let(:item) { create :item }
  let(:comment) { item.comments.create! valid_attributes }
  let(:location) { item.location }

  describe "GET /index" do
    it "renders a successful response" do
      get location_item_comments_path(location, item)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get location_item_comment_path(location, item, comment)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_location_item_comment_path(location, item)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    subject(:post_comment) do
      post location_item_comments_path(location, item), params: { comment: params }
    end

    context "with valid parameters" do
      let(:params) { valid_attributes }
      it "creates a new Comment" do
        expect {
          post_comment
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the item the comment was created on" do
        post_comment
        expect(response).to redirect_to(location_item_path(location, Item.last))
      end
    end

    context "with invalid parameters" do
      let(:params) { invalid_attributes }
      it "does not create a new Comment" do
        expect {
          post_comment
        }.to change(Comment, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post_comment
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_location_item_comment_path(location, item, comment)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        attributes_for :comment
      end

      it "updates the requested comment" do
        patch location_item_comment_path(location, item, comment), params: { comment: new_attributes }
        comment.reload
        expect(comment.body).to eq(new_attributes[:body])
      end

      it "redirects to the item associated with the requested comment" do
        patch location_item_comment_path(location, item, comment), params: { comment: new_attributes }
        comment.reload
        expect(response).to redirect_to(location_item_path(location, item))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch location_item_comment_path(location, item, comment), params: { comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested comment" do
      item
      comment
      expect {
        delete location_item_comment_path(location, item, comment)
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the item" do
      delete location_item_comment_path(location, item, comment)
      expect(response).to redirect_to(location_item_path(location, item))
    end
  end
end
