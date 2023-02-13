class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :set_item, only: %i[show edit update destroy create index new]

  def index
    @comments = Comment.all
  end

  def show; end

  def new
    @comment = @item.comments.new
  end

  def edit; end

  def create
    @comment = @item.comments.new(comment_params)

    if @comment.save
      redirect_to @item, notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @item, notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @item, notice: "Comment was successfully destroyed."
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body, :item_id)
  end
end
