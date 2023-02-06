# frozen_string_literal: true

class ApplicationController < ActionController::Base
  require "govuk_design_system_formbuilder"
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder
end
