# frozen_string_literal: true

# Provider of the app's root page
class HomeController < ApplicationController
  def index
    @locations = Location.roots
    @most_popular_item = ItemView.most_popular_item
  end
end
