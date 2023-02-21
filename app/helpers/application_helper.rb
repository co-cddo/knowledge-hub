# frozen_string_literal: true

# Container for generic helper methods used across app
module ApplicationHelper
  require "govspeak"
  def govspeak_to_html(govspeak)
    return unless govspeak.present?

    doc = Govspeak::Document.new govspeak
    doc.to_html.html_safe
  end

  def item_path(item)
    location_item_path(item.location, item)
  end

  # This is a horrible hack, but I've been unable to find a better solution.
  # If tmp/cache is empty when an asset path is first called an error occurs:
  #  ` LoadError: cannot load such file -- sassc`
  # sassc is not present in this app, so it looks like a relic of older Rails systems.
  # The code below catches that error and then waits for the tmp/cache to build.
  # The first call to render the page generates the tmp/cache build even if it errors.
  def catch_load_error
    yield
  rescue LoadError
    sleep 0.1
    retry
  end
end
