# frozen_string_literal: true

# Container for generic helper methods used across app
module ApplicationHelper
  require "govspeak"
  def govspeak_to_html(govspeak)
    doc = Govspeak::Document.new govspeak
    doc.to_html.html_safe
  end
end
