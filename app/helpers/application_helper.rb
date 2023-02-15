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
end
