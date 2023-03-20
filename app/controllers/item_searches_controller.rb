class ItemSearchesController < ApplicationController
  def index
    @search = ItemsSearch.search(query: params[:query], location_id:)
  end

private

  def location_id
    return unless location
    return location.id unless params[:include_sub_locations]

    [location.id] + location.children.map(&:id)
  end

  def location
    return unless params[:id].present?

    # finding the location to ensure id matches a location
    @location ||= Location.find(params[:id])
  end
end
