class CommentsController < ApplicationController
  before_action :set_item_and_location
  before_action :comment, only: %i[show edit new]

  def index
    @comments = Comment.all
  end

  def show; end

  def new; end

  def create
    @comment = item.comments.new(comment_params)

    if comment.save
      redirect_to [location, item], notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if comment.update(comment_params)
      redirect_to [location, item], notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    comment.destroy
    redirect_to [location, item], notice: "Comment was successfully destroyed."
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def comment
    @comment ||= params[:id].present? ? Comment.find(params[:id]) : item.comments.new
  end

  def item
    @item ||= Item.find(params[:item_id])
  end

  def location
    @location ||= Location.find(params[:location_id])
  end

  def set_item_and_location
    item
    location
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body, :item_id)
  end
end
