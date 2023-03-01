# frozen_string_literal: true

class ItemsController < ApplicationController
  around_action :use_chewy_active_job_strategy, only: %i[create update destroy]

  # GET /items
  def index
    @items = location.items.roots
  end

  # GET /items/1
  def show
    item
  end

  # GET /items/new
  def new
    @item = location.items.build
  end

  # GET /items/1/edit
  def edit
    item
  end

  # POST /items
  def create
    @item = location.items.build(item_params)
    if item.save
      redirect_to [location, item], notice: "Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if item.update(item_params)
      redirect_to [location, item], notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    item.destroy
    redirect_to location_items_path(location), notice: "Item was successfully destroyed."
  end

private

  def item
    @item ||= location.items.find(params[:id])
  end

  def location
    @location ||= Location.find(params[:location_id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:name, :source_url, :tag_list, :description, :parent_id).tap do |hash|
      return hash if hash[:tag_list].blank?

      hash[:tag_list] = JSON.parse(hash[:tag_list]).map { |h| h["value"] }.join(",")
    end
  end
end
