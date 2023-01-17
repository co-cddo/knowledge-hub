# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#govspeak_to_html' do
    it 'renders the markdown' do
      expect(helper.govspeak_to_html('Hello')).to eq("<p>Hello</p>\n")
    end
  end
end
