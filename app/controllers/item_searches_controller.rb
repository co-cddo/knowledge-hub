class ItemSearchesController < ApplicationController
  def index
    @search = ItemsSearch.search(params[:query])
  end
end
